require "rack"
require 'webrick'
require 'json'
require 'uri'
require_relative '../rule_engine'
require_relative '../visitors/configuration_visitor'
require_relative '../facades/configuration_page_facade'
require_relative '../facades/configuration_file_facade'

class LinterServer

  def call(env)
    req = Rack::Request.new(env)

    case req.path
    when "/configuration"
      if req.post?
        process_form(req)
      elsif req.get?
        configurations_page
      end
    end

  end

  def configurations_page
    configuration_page = ConfigurationPageFacade.AssemblePage

    return [200, { 'Content-Type' => 'text/html' }, [configuration_page]]
  end

  def process_form(req)
    new_conf = URI.decode_www_form(req.body.read)
    new_conf_hash = Hash[new_conf.map {|key, value| [key, value]}]

    begin
      ConfigurationPageFacade.ApplyConfigurations(new_conf_hash)
      ConfigurationFileFacade.SaveConfigurations
    rescue StandardError => error
      return [400, { 'Content-Type' => 'text/plain' }, ["Error: #{error.message}"]]
    end

    return [200, { 'Content-Type' => 'text/plain' }, ["Changes saved successfully"]]
  end

  def self.start(port)
    log = WEBrick::Log.new $stdout,1
    Rack::Handler::WEBrick.run(LinterServer.new, :Port => port,Logger: log )
  end

end
