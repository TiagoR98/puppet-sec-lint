require_relative 'list_configuration'

class HardCodedCredentialsRule < Rule
  @default_trigger_words = %w[pwd password pass uuid key crypt secret certificate id cert token ssh_key md5 rsa ssl]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a variable with credentials")

  @name = "Hard Coded Credentials"
  @configurations+=[@trigger_words_conf]

  def self.AnalyzeTokens(tokens)
    tokens.each do |indi_token|
      nxt_token     = indi_token.next_code_token # next token which is not a white space
      if (!nxt_token.nil?) && (!indi_token.nil?)
        token_type   = indi_token.type.to_s ### this gives type for current token

        token_line   = indi_token.line ### this gives type for current token
        nxt_tok_line = nxt_token.line

        nxt_nxt_token =  nxt_token.next_code_token # get the next next token to get key value pair

        if  (!nxt_nxt_token.nil?)
          nxt_nxt_line = nxt_nxt_token.line
          if (token_type.eql? 'NAME') || (token_type.eql? 'VARIABLE')
            # puts "Token type: #{token_type}"
            if (token_line==nxt_nxt_line)
              token_valu   = indi_token.value.downcase
              nxt_nxt_val  = nxt_nxt_token.value.downcase
              nxt_nxt_type = nxt_nxt_token.type.to_s  ## to handle false positives,

              if (self.TriggerWordInString(token_valu)) && ((nxt_nxt_val.length > 0)) && ((!nxt_nxt_type.eql? 'VARIABLE') && (!token_valu.include? "("))
                warning = {
                  message: 'SECURITY:::HARD_CODED_SECRET_V1:::Do not hard code secrets. This may help an attacker to attack the system. You can use hiera to avoid this issue.',
                  line:    indi_token.line,
                  column:  indi_token.column,
                  token:   token_valu
                }

                puts warning
              end
            end
          end
        end
      end
    end
  end

  def self.TriggerWordInString(string)
    return @trigger_words_conf.value.any? { |word| string.include?(word) }
  end
end