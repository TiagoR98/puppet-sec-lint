require_relative '../configurations/list_configuration'

class UseWeakCryptoAlgorithmsRule < Rule
  @name = "Use of weak crypto algorithm"

  @poor_crypto = /^(sha1|md5)/

  @poor_crypto_conf = RegexConfiguration.new("Regular expression of weak Crypto Algorithms", @poor_crypto, "Regular expression for names of known weak Cryptographic algorithms that shouldn't be used to secure sensitive information.")

  @configurations+=[@poor_crypto_conf]

  def self.AnalyzeTokens(tokens)
    result = []

    tokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if !token.next_token.nil?
        next_token_type = token.next_token.type.to_s
      end
      if (token_value =~ @poor_crypto_conf.value) && (next_token_type.eql? "LPAREN")
        result.append(Sin.new(SinType::WeakCryptoAlgorithm, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end
end