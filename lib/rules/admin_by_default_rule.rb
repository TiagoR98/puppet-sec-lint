require_relative '../configurations/list_configuration'

class AdminByDefaultRule < Rule
  @name = "Admin by default"

  CREDENTIALS = /user|usr|pass(word|_|$)|pwd/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.get_tokens(tokens,'admin')
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if ["EQUALS", "FARROW"].include? token.prev_code_token.type.to_s
        prev_token = token.prev_code_token
        left_side = prev_token.prev_code_token
        if left_side.value.downcase =~ CREDENTIALS and ["VARIABLE", "NAME"].include? left_side.type.to_s
          if token_value == 'admin'
            result.append(Sin.new(SinType::AdminByDefault, left_side.line, left_side.column, token.line, token.column+token_value.length))
          end
        end
      end
    end

    return result
  end

end