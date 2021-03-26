require 'puppet-lint'
require_relative 'rule'
require 'hard_coded_credentials_rule'

class RuleEngine
  @@rules=[HardCodedCredentialsRule]

  def self.getTokens(code)
    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)
    return tokens
  end


  def self.analyzeDocument(code)
    tokens = self.getTokens(code)

    @@rules.each do |rule|
      rule.AnalyzeTokens(tokens)
    end

  end

end
