require_relative '../configurations/list_configuration'
require_relative '../configurations/regex_configuration'

class HardCodedCredentialsRule < Rule
  @not_considered_creds = %w[pe-puppet pe-webserver pe-puppetdb pe-postgres pe-console-services pe-orchestration-services pe-ace-server pe-bolt-server]
  @invalid_values = %w[undefined unset www-data wwwrun www no yes [] root]
  @secrets = /user|usr|pass(word|_|$)|pwd|key|secret/
  @non_secrets = /gpg|path|type|buff|zone|mode|tag|header|scheme|length|guid/

  @not_considered_creds_conf = ListConfiguration.new("List of known words not considered in credentials", @not_considered_creds, "List of words not considered secrets by the community  (https://puppet.com/docs/pe/2019.8/what_gets_installed_and_where.html#user_and_group_accounts_installed)")
  @invalid_values_conf = ListConfiguration.new("List of invalid values in credentials", @invalid_values, "List of words that are not valid in a credential, advised by puppet specialists.")
  @secrets_conf = RegexConfiguration.new("Regular expression of words present in credentials", @secrets, "Regular expression of words that if present indicate the existence of a secret.")
  @non_secrets_conf = RegexConfiguration.new("Regular expression of words not present in credentials", @non_secrets, "Regular expression of words that if present discard the existence of a secret.")

  @name = "Hard Coded Credentials"
  @configurations+=[@not_considered_creds_conf, @invalid_values_conf, @secrets_conf, @non_secrets_conf]

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.filter_tokens(tokens)
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      next_token = token.next_code_token
      # accepts <VARIABLE> <EQUALS> secret OR <NAME> <FARROW> secret, checks if <VARIABLE> | <NAME> satisfy SECRETS but not satisfy NON_SECRETS
      if ["VARIABLE", "NAME"].include? token_type and ["EQUALS", "FARROW"].include? next_token.type.to_s and token_value =~ @secrets_conf.value and !(token_value =~ @non_secrets_conf.value)
        right_side_type = next_token.next_code_token.type.to_s
        right_side_value = next_token.next_code_token.value.downcase
        if ["STRING", "SSTRING"].include? right_side_type and right_side_value.length > 1 and !@invalid_values_conf.value.include? right_side_value and !(right_side_value =~ /::|\/|\.|\\/ ) and !@not_considered_creds_conf.value.include? right_side_value
          result.append(Sin.new(SinType::HardCodedCred, token.line, token.column, next_token.next_code_token.line, next_token.next_code_token.column+right_side_value.length))
        end
      end
    end

    return result
  end

end