require_relative '../configurations/list_configuration'

class CyrillicHomographAttack < Rule
  @name = "Cyrillic Homograph attack"

  @site_w_cyrillic = /^(http(s)?:\/\/)?.*\p{Cyrillic}+/

  @site_w_cyrillic_conf = RegexConfiguration.new("Regular expression of links with Cyrillic characters", @site_w_cyrillic, "Regular expression of website links that have Cyrillic characters.")

  @configurations+=[@site_w_cyrillic_conf]

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.filter_tokens(tokens)
    tokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["STRING", "SSTRING"].include? token_type and token_value =~ @site_w_cyrillic_conf.value
        result.append(Sin.new(SinType::CyrillicHomographAttack, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end

end