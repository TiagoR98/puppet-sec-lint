require "rack"
require "thin"
require 'json'
require_relative 'rule_engine'
require_relative 'configuration_visitor'

class LanguageServer
  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      process_analysis(req)
    elsif req.get?
      configurations_page(req)
    end

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
    result = ConfigurationVisitor.Visit

    return [200, { 'Content-Type' => 'application/text' }, [result]]
  end

end

Rack::Handler::Thin.run(LanguageServer.new, :Port => 9292)
