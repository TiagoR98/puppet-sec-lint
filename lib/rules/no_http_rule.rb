require_relative '../configurations/list_configuration'
require_relative '../sin/sin'
require_relative '../sin/sin_type'

class NoHTTPRule < Rule
  @name="No HTTPS Connections"

  @whitelist = []
  HTTP = /^http:\/\/.+/


  def self.AnalyzeTokens(tokens)
    result = []

    resources = ['apt::source', '::apt::source', 'wget::fetch', 'yumrepo', 'yum::', 'aptly::mirror', 'util::system_package', 'yum::managed_yumrepo']
    ptokens = self.filter_resources(tokens, resources)
    keywords = ['backport', 'key', 'download', 'uri', 'mirror']
    ctokens = self.filter_variables(ptokens, keywords)
    if @whitelist
      wtokens = self.filter_whitelist(ctokens)
    else
      wtokens = ptokens
    end
    wtokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if (token_value =~ HTTP)
        result.append(Sin.new(SinType::HttpWithoutTLS, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end

  def self.filter_whitelist(tokens)
    ftokens=tokens.find_all do |hash|
      !(@whitelist =~ hash.value.downcase)
    end
    return ftokens
  end

  def self.filter_variables(tokens, keywords)
    line = -1
    kw_regex = Regexp.new keywords.join("|")
    ftokens=tokens.find_all do |hash|
      if (hash.type.to_s == 'VARIABLE' || hash.type.to_s == 'NAME') and hash.value.downcase =~ kw_regex
        line = hash.line
      elsif hash.line != line
        hash
      end
    end
  end


end