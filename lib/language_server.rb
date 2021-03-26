
class LanguageServer
  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      process_analysis(req)
    end

  end

  def process_analysis(req)
    body = JSON.parse(req.body.read)

    if body['documentContent']
      text = body['documentContent'].split("\n")

      tokens = RuleEngine.getTokens(body['documentContent'])

      return [200, { 'Content-Type' => 'application/json' }, [tokens.to_json]]
    end

    [401, { 'Content-Type' => 'text/html' }, ['Invalid Request']]
  end

end
