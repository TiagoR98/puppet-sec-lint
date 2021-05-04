require_relative '../configurations/list_configuration'

class InvalidIPAddrBindingRule < Rule
  @name = "Invalid IP Address Binding"

  @ip_addr_bin_regex = /^((http(s)?:\/\/)?0.0.0.0(:\d{1,5})?)$/

  IP_ADDR_BIN_REGEX = /^((http(s)?:\/\/)?0.0.0.0(:\d{1,5})?)$/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = get_tokens(tokens,"0.0.0.0")
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["EQUALS", "FARROW"].include? token.prev_code_token.type.to_s
        prev_token = token.prev_code_token
        left_side = prev_token.prev_code_token
        if token_value =~ IP_ADDR_BIN_REGEX and ["VARIABLE", "NAME"].include? left_side.type.to_s
          result.append(Sin.new(SinType::InvalidIPAddrBinding, prev_token.line, prev_token.column, token.line, token.column+token_value.length))
        end
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