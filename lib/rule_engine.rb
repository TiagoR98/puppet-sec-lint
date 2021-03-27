require 'puppet-lint'
require_relative 'rules/rule'
require_relative 'rules/hard_coded_credentials_rule'
require_relative 'rules/no_http_rule'


class RuleEngine
  @rules=[HardCodedCredentialsRule,NoHTTPRule]

  class << self
    attr_accessor :rules
  end

  def self.getTokens(code)
    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)
    return tokens
  end


  def self.analyzeDocument(code)
    tokens = self.getTokens(code)

    @rules.each do |rule|
      if rule.configurations[0].value
        rule.AnalyzeTokens(tokens)
      end
    end

  end

end
