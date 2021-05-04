require_relative '../configurations/list_configuration'

class SuspiciousCommentRule < Rule
  @trigger_words = %w[hack fixme later later2 todo ticket launchpad bug to-do]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @trigger_words, "List of words that identify a suspicious comment")

  @configurations+=[@trigger_words_conf]

  @name = "Suspicious comments"

  SUSPICIOUS = /hack|fixme|ticket|bug|secur|debug|defect|weak/

  def self.AnalyzeTokens(tokens)
    result = []

    ftokens = self.get_comments(tokens)
    ftokens.each do |token|
      token_value = token.value.downcase
      token_type = token.type.to_s
      if (token_value =~ SUSPICIOUS)
        result.append(Sin.new(SinType::SuspiciousComments, token.line, token.column, token.line, token.column+token_value.length))
      end
    end

    return result
  end
end