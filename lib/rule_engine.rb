require 'puppet-lint'
require_relative 'rules/rule'
require_relative 'rules/hard_coded_credentials_rule'
require_relative 'rules/no_http_rule'
require_relative 'rules/admin_by_default_rule'
require_relative 'rules/empty_password_rule'
require_relative 'rules/invalid_ip_addr_binding_rule'
require_relative 'rules/suspicious_comment_rule'
require_relative 'rules/use_of_crypto_algorithms_rule'
require_relative 'rules/cyrillic_homograph_attack'


class RuleEngine
  @rules=[HardCodedCredentialsRule,NoHTTPRule,AdminByDefaultRule,EmptyPasswordRule,InvalidIPAddrBindingRule,UseWeakCryptoAlgorithmsRule,SuspiciousCommentRule,CyrillicHomographAttack]

  class << self
    attr_accessor :rules
  end

  def self.getTokens(code)
    begin
      lexer = PuppetLint::Lexer.new
      tokens = lexer.tokenise(code)
    rescue
      puts "Error in getting tokens from Puppet-Lint"
      tokens = []
    end

    return tokens
  end

  def self.analyzeDocument(code)
    result=[]
    tokens = self.getTokens(code)

    @rules.each do |rule|
      if rule.configurations[0].value
        (result << rule.AnalyzeTokens(tokens)).flatten!
      end
    end

    return result
  end

end
