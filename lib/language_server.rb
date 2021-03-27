require "rack"
require "thin"
require 'json'
require 'uri'
require_relative 'rule_engine'
require_relative 'visitors/configuration_visitor'
require_relative 'configuration_page_manager'

class LanguageServer
  def call(env)
    req = Rack::Request.new(env)

    case req.path
    when "/"
      if req.post?
        process_analysis(req)
      end
    when "/configuration"
      if req.post?
        process_form(req)
      elsif req.get?
        configurations_page(req)
      end
    end

  end

  def process_form(req)
    new_conf = URI.decode_www_form(req.body.read)
    new_conf_hash = Hash[new_conf.map {|key, value| [key, value]}]


    configuration_hash = ConfigurationVisitor.Visit
    ConfigurationPageManager.ApplyConfigurations(configuration_hash, new_conf_hash)


    return [200, { 'Content-Type' => 'text/plain' }, ["Changes saved successfully"]]
  end

  def process_analysis(req)
    body = JSON.parse(req.body.read)

    if body['file']
      File.open(body['file'], 'rb:UTF-8') do |f|
        code = f.read

        RuleEngine.analyzeDocument(code)
      end

      return [200, { 'Content-Type' => 'application/text' }, ["good"]]
    end

    [401, { 'Content-Type' => 'text/html' }, ['Invalid Request']]
  end

  def configurations_page(req)
    configuration_hash = ConfigurationVisitor.Visit
    configuration_page = ConfigurationPageManager.AssemblePage(configuration_hash)

    return [200, { 'Content-Type' => 'text/html' }, [configuration_page]]
  end

end

Rack::Handler::Thin.run(LanguageServer.new, :Port => 9292)
