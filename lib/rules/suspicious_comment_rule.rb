require_relative '../configurations/list_configuration'

class SuspiciousCommentRule < Rule
  @trigger_words = %w[hack fixme later later2 todo ticket launchpad bug to-do]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @trigger_words, "List of words that identify a suspicious comment")

  @configurations+=[@trigger_words_conf]

  @name = "Check empty password"

  def self.AnalyzeTokens(tokens)
    result = []

    tokens.each do |token|
      ##first check if string starts with #, which is comemnt in Puppet
      ### check if those keywords exist
      single_line=token.value.to_s
      single_line=single_line.downcase
      single_line=single_line.strip
      # (single_line.include?('show_bug') || removing show_bug, as it generates duplicates
      if (self.TriggerWordInString(single_line)) && (!single_line.include?('debug'))
       result.append(Sin.new(SinType::SuspiciousComments, token.line, token.column, token.line, token.column+token.value.length))
      end
    end

    return result
  end

  def self.TriggerWordInString(string)
    return @trigger_words_conf.value.any? { |word| string.include?(word) }
  end
end