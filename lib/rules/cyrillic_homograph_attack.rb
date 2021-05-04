require_relative '../configurations/list_configuration'

class CyrillicHomographAttack < Rule
  @name = "Cyrillic Homograph attack"

  SITE_W_CYRILLIC = /^(http(s)?:\/\/)?.*\p{Cyrillic}+/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.filter_tokens(tokens)
    tokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["STRING", "SSTRING"].include? token_type and token_value =~ SITE_W_CYRILLIC
        result.append(Sin.new(SinType::CyrillicHomographAttack, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end

end