require_relative '../configurations/list_configuration'

class EmptyPasswordRule < Rule
  @default_trigger_words = %w[pwd password pass]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a password variable")

  @configurations+=[@trigger_words_conf]

  @name = "Check empty password"

  PASSWORD = /pass(word|_|$)|pwd/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.get_string_tokens(tokens,'')
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["EQUALS", "FARROW"].include? token.prev_code_token.type.to_s
        prev_token = token.prev_code_token
        left_side = prev_token.prev_code_token
        if left_side.value.downcase =~ PASSWORD and ["VARIABLE", "NAME"].include? left_side.type.to_s
          if token_value == ''
            result.append(Sin.new(SinType::EmptyPassword, prev_token.line, prev_token.column, token.line, token.column+token_value.length))
          end
        end
      end
    end

    return result
  end

end