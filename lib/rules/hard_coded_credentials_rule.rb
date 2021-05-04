require_relative '../configurations/list_configuration'

class HardCodedCredentialsRule < Rule
  @default_trigger_words = %w[pwd password pass key crypt secret certificate cert ssh_key md5 rsa ssl dsa dsa]
  @invalid_kw_list = %w[( undef true false hiera secret union $ { regsubst hiera_hash pick get_ssl_property inline_template under mysql_password / ssl_ciphersuite ::] # doesnt work becuase include assumes entire string
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a variable with credentials")
  @invalid_kw_conf = ListConfiguration.new("List of invalid keywords", @default_trigger_words, "List of keywords that can't be present in a password")

  @name = "Hard Coded Credentials"
  @configurations+=[@trigger_words_conf,@invalid_kw_conf]

  SECRETS = /user|usr|pass(word|_|$)|pwd|key|secret/
  NON_SECRETS = /gpg|path|type|buff|zone|mode|tag|header|scheme|length|guid/

  def self.AnalyzeTokens(tokens)
    result = []

    # list of known credentials - not considered secrets by the community (https://puppet.com/docs/pe/2019.8/what_gets_installed_and_where.html#user_and_group_accounts_installed)
    user_default = ['pe-puppet', 'pe-webserver', 'pe-puppetdb', 'pe-postgres', 'pe-console-services', 'pe-orchestration-services','pe-ace-server', 'pe-bolt-server']
    # some were advised by puppet specialists
    invalid_values = ['undefined', 'unset', 'www-data', 'wwwrun', 'www', 'no', 'yes', '[]', 'root']
    ftokens = self.filter_tokens(tokens)
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      next_token = token.next_code_token
      # accepts <VARIABLE> <EQUALS> secret OR <NAME> <FARROW> secret, checks if <VARIABLE> | <NAME> satisfy SECRETS but not satisfy NON_SECRETS
      if ["VARIABLE", "NAME"].include? token_type and ["EQUALS", "FARROW"].include? next_token.type.to_s and token_value =~ SECRETS and !(token_value =~ NON_SECRETS)
        right_side_type = next_token.next_code_token.type.to_s
        right_side_value = next_token.next_code_token.value.downcase
        if ["STRING", "SSTRING"].include? right_side_type and right_side_value.length > 1 and !invalid_values.include? right_side_value and !(right_side_value =~ /::|\/|\.|\\/ ) and !user_default.include? right_side_value
          result.append(Sin.new(SinType::HardCodedCred, token.line, token.column, next_token.next_code_token.line, next_token.next_code_token.column+right_side_value.length))
        end
      end
    end

    return result
  end

end