require_relative '../configurations/list_configuration'
require_relative '../sin/sin'
require_relative '../sin/sin_type'

class NoHTTPRule < Rule
  @name="No HTTPS Connections"

  def self.AnalyzeTokens(tokens)
    result = []

    tokens.each do |indi_token|
      token_valu = indi_token.value ### this gives each token
      token_valu = token_valu.downcase
      token_type = indi_token.type.to_s
      if (token_valu.include? "http://" ) && (!token_type.eql? "COMMENT")
        result.append(Sin.new(SinType::HttpWithoutTLS, indi_token.line, indi_token.column, indi_token.line, indi_token.column+indi_token.value.length))
      end
    end

    return result
  end

end