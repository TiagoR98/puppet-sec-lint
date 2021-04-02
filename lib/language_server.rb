require "rack"
require "thin"
require 'json'
require 'uri'
require_relative 'rule_engine'
require_relative 'visitors/configuration_visitor'
require_relative 'facades/configuration_page_facade'

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
        configurations_page
      end
    end

  end

  def process_form(req)
    new_conf = URI.decode_www_form(req.body.read)
    new_conf_hash = Hash[new_conf.map {|key, value| [key, value]}]

    ConfigurationPageFacade.ApplyConfigurations(new_conf_hash)

    return [200, { 'Content-Type' => 'text/plain' }, ["Changes saved successfully"]]
  end

  def process_analysis(req)
    body = JSON.parse(req.body.read)

    if body['documentContent']
      code = body['documentContent']

      result_json = []

      result = RuleEngine.analyzeDocument(code) #convert to json

      result.each do |sin|
        result_json.append(JSON.generate({
                             'name' => sin.type[:name],
                             'message' => sin.type[:message],
                             'recommendation' => sin.type[:recommendation],
                             'begin_line' => sin.begin_line,
                             'begin_char' => sin.begin_char,
                             'end_line' => sin.end_line,
                             'end_char' => sin.end_char
                           }))
      end

      return [200, { 'Content-Type' => 'application/json' }, [result_json.to_json]]
    end

    [401, { 'Content-Type' => 'text/html' }, ['Invalid Request']]
  end

  def configurations_page
    configuration_page = ConfigurationPageFacade.AssemblePage

    return [200, { 'Content-Type' => 'text/html' }, [configuration_page]]
  end

end

Rack::Handler::Thin.run(LanguageServer.new, :Port => 9292)
