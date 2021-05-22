require_relative '../configurations/list_configuration'
require_relative '../sin/sin'
require_relative '../sin/sin_type'

class NoHTTPRule < Rule
  @name="No HTTPS Connections"

  @resources = %w[apt::source ::apt::source wget::fetch yumrepo yum:: aptly::mirror util::system_package yum::managed_yumrepo]
  @keywords = %w[backport key download uri mirror]
  @http = /^http:\/\/.+/
  @whitelist = ""

  @resources_conf = ListConfiguration.new("List of resources that can use HTTP", @resources, "List of resources that are known to not use HTTPS but that validate the transferred content with other secure methods.")
  @keywords_conf = ListConfiguration.new("List of keywords for URLs", @keywords, "List of keywords that identify hyperlinks that should be analyzed.")
  @whitelist_conf = RegexConfiguration.new("HTTP Address whitelist", @whitelist, "List of addresses that are allowed to have non-secure http connections to them.")
  @http_conf = RegexConfiguration.new("Regular expression of a normal HTTP address", @http, "Regular expression that identifies the URL of a website using the regular non-secure HTTP protocol.")

  @configurations+=[@resources_conf, @keywords_conf, @http_conf, @whitelist_conf]

  def self.AnalyzeTokens(tokens)
    result = []

    ptokens = self.filter_resources(tokens, @resources_conf.value)
    ctokens = self.filter_variables(ptokens, @keywords_conf.value) #TODO: It's working upside down
    if not @whitelist_conf.value.empty?
      wtokens = self.filter_whitelist(ctokens, @whitelist_conf.value)
    else
      wtokens = ptokens
    end
    wtokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if (token_value =~ @http_conf.value)
        result.append(Sin.new(SinType::HttpWithoutTLS, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end

end