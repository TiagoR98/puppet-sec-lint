require_relative '../configurations/list_configuration'

class InvalidIPAddrBindingRule < Rule
  @name = "Invalid IP Address Binding"

  @ip_addr_bin_regex = /^((http(s)?:\/\/)?0.0.0.0(:\d{1,5})?)$/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.filter_tokens_per_value(tokens,"0.0.0.0")
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if token_value =~ @ip_addr_bin_regex and token.prev_code_token.type.to_s != "ISEQUAL"
        result.append(Sin.new(SinType::InvalidIPAddrBinding, token.line, token.column, token.line, token.column+token.value.length))
      end
    end

    return result
  end

  def self.filter_tokens_per_value(tokens, token)
    ftokens=tokens.find_all do |hash|
      (hash.type.to_s == 'SSTRING' || hash.type.to_s == 'STRING') and hash.value.downcase.include? token
    end
    return ftokens
  end
end