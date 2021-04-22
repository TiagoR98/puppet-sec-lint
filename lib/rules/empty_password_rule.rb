require_relative '../configurations/list_configuration'

class EmptyPasswordRule < Rule
  @default_trigger_words = %w[pwd password pass]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a password variable")

  @configurations+=[@trigger_words_conf]

  @name = "Check empty password"

  def self.AnalyzeTokens(tokens)
    result = []

    tokens.each do |indi_token|
      nxt_token     = indi_token.next_code_token # next token which is not a white space
      if (!nxt_token.nil?) && (!indi_token.nil?)
        token_type   = indi_token.type.to_s ### this gives type for current token

        token_line   = indi_token.line ### this gives type for current token

        nxt_nxt_token =  nxt_token.next_code_token # get the next next token to get key value pair

        if !nxt_nxt_token.nil?
          nxt_nxt_line = nxt_nxt_token.line
          if (token_type.eql? 'NAME') || (token_type.eql? 'VARIABLE') || (token_type.eql? 'SSTRING')
            # puts "Token type: #{token_type}"
            if token_line == nxt_nxt_line
              token_valu  = indi_token.value.downcase
              nxt_nxt_val = nxt_nxt_token.value.downcase
              # puts "KEY,PAIR----->#{token_valu}, #{nxt_nxt_val}"
              if self.TriggerWordInString(token_valu) && (((nxt_nxt_val.length <= 0) || (nxt_nxt_val.eql? ' ')) && (!nxt_nxt_val.include? "$"))
                result.append(Sin.new(SinType::EmptyPassword, indi_token.line, indi_token.column, nxt_nxt_token.line, nxt_nxt_token.column+nxt_nxt_token.value.length))
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