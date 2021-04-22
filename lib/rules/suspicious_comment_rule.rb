require_relative '../configurations/list_configuration'

class SuspiciousCommentRule < Rule
  @trigger_words = %w[hack fixme later later2 todo ticket launchpad bug to-do]
  @trigger_words_conf = ListConfiguration.new("List of trigger words", @default_trigger_words, "List of words that identify a password variable")

  @configurations+=[@default_trigger_words]

  @name = "Check empty password"

  def self.AnalyzeTokens(tokens)
    result = []

    lineNo=0
    manifest_lines.each do |single_line|
      lineNo += 1
      ##first check if string starts with #, which is comemnt in Puppet
      if single_line.include? '#'
        ### check if those keywords exist
        single_line=single_line.downcase
        single_line=single_line.strip
        # (single_line.include?('show_bug') || removing show_bug, as it generates duplicates
        if (self.TriggerWordInString(single_line)) && (!single_line.include?('debug'))
         result.append(Sin.new(SinType::SuspiciousComments, lineNo, 0, lineNo, 0+single_line.value.length))
        end
      end
    end

    return result
  end

  def self.TriggerWordInString(string)
    return @default_trigger_words.value.any? { |word| string.include?(word) }
  end
end