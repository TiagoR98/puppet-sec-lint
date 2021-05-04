require_relative '../configurations/list_configuration'

class EmptyPasswordRule < Rule
  @default_trigger_words = %w[pwd password pass]
  @password = /pass(word|_|$)|pwd/

  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a password variable")
  @password_conf = RegexConfiguration.new("Regular expression of password name", @password, "Regular expression of names used for password variables.")

  @configurations+=[@trigger_words_conf, @password_conf]

  @name = "Check empty password"

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.get_string_tokens(tokens,'')
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["EQUALS", "FARROW"].include? token.prev_code_token.type.to_s
        prev_token = token.prev_code_token
        left_side = prev_token.prev_code_token
        if left_side.value.downcase =~ @password_conf.value and ["VARIABLE", "NAME"].include? left_side.type.to_s
          if token_value == ''
            result.append(Sin.new(SinType::EmptyPassword, prev_token.line, prev_token.column, token.line, token.column+token_value.length))
          end
        end
      end
    end

    return result
  end

end