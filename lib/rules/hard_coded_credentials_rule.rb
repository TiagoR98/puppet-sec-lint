require_relative '../configurations/list_configuration'

class HardCodedCredentialsRule < Rule
  @default_trigger_words = %w[pwd password pass key crypt secret certificate cert ssh_key md5 rsa ssl dsa dsa]
  @invalid_kw_list = %w[( undef true false hiera secret union $ { regsubst hiera_hash pick get_ssl_property inline_template under mysql_password / ssl_ciphersuite ::] # doesnt work becuase include assumes entire string
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a variable with credentials")
  @invalid_kw_conf = ListConfiguration.new("List of invalid keywords", @default_trigger_words, "List of keywords that can't be present in a password")

  @name = "Hard Coded Credentials"
  @configurations+=[@trigger_words_conf,@invalid_kw_conf]

  def self.AnalyzeTokens(tokens)
    result = []

    tokens.each do |indi_token|
      nxt_token     = indi_token.next_code_token # next token which is not a white space
      if (!nxt_token.nil?) && (!indi_token.nil?)
        token_type   = indi_token.type.to_s ### this gives type for current token

        token_line   = indi_token.line ### this gives type for current token

        nxt_nxt_token =  nxt_token.next_code_token # get the next next token to get key value pair

        if  (!nxt_nxt_token.nil?)
          nxt_nxt_line = nxt_nxt_token.line
          if (token_type.eql? 'NAME') || (token_type.eql? 'VARIABLE')
            # puts "Token type: #{token_type}"
            if (token_line==nxt_nxt_line)
              token_valu   = indi_token.value.downcase
              nxt_nxt_val  = nxt_nxt_token.value.downcase
              nxt_nxt_type = nxt_nxt_token.type.to_s  ## to handle false positives,

              if ((self.TriggerWordInString(token_valu)) && (!token_valu.include? "::") && (!token_valu.include? "passive")) &&
                 ((!token_valu.include? "provider") && (!nxt_nxt_type.eql? 'VARIABLE') && (!@invalid_kw_list.include? nxt_nxt_val) && (nxt_nxt_val.length > 1))
                result.append(Sin.new(SinType::HardCodedCred, indi_token.line, indi_token.column, nxt_nxt_token.line, nxt_nxt_token.column+nxt_nxt_token.value.length))
              end
            end
          end
        end
      end
    end

    return result
  end

  def self.TriggerWordInString(string)
    return @trigger_words_conf.value.any? { |word| string.include?(word) }
  end
end