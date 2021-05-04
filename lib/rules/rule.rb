require_relative '../configurations/boolean_configuration'

class Rule

  def self.inherited(subclass)
    subclass.configurations = [BooleanConfiguration.new("Enable Configuration", true, "Enable or disable the evaluation of the rules")]
  end

  class << self
    attr_accessor :name, :configurations
  end

  def self.AnalyzeTokens(tokens)
    puts "Implement this"
    return
  end

  def self.get_tokens(tokens, token)
    ftokens=tokens.find_all do |hash|
      (hash.type.to_s == 'NAME' || hash.type.to_s == 'VARIABLE' || hash.type.to_s == 'SSTRING' || hash.type.to_s == 'STRING') and hash.value.downcase.include? token
    end
    return ftokens
  end

  def self.filter_tokens(tokens)
    ftokens=tokens.find_all do |hash|
      (hash.type.to_s == 'SSTRING' || hash.type.to_s == 'STRING' || hash.type.to_s == 'VARIABLE' || hash.type.to_s == 'NAME')
    end
    return ftokens
  end

  def self.filter_resources(tokens, resources)
    is_resource = false
    brackets = 0
    ftokens=tokens.find_all do |hash|

      if resources.include? hash.value.downcase
        is_resource = true
      elsif is_resource and hash.type.to_s == "LBRACE"
        brackets += 1
      elsif is_resource and hash.type.to_s == "RBRACE"
        brackets -=1
      end

      if is_resource and hash.type.to_s == "RBRACE" and brackets == 0
        is_resource = false
      end

      if !is_resource
        (hash.type.to_s == 'NAME' || hash.type.to_s == 'VARIABLE' || hash.type.to_s == 'SSTRING' || hash.type.to_s == 'STRING')
      end
    end
    return ftokens
  end

  def self.get_string_tokens(tokens, token)
    ftokens=tokens.find_all do |hash|
      (hash.type.to_s == 'SSTRING' || hash.type.to_s == 'STRING') and hash.value.downcase.include? token
    end
    return ftokens
  end

  def self.get_comments(tokens)
    ftokens=tokens.find_all do |hash|
      (hash.type.to_s == 'COMMENT' || hash.type.to_s == 'MLCOMMENT' || hash.type.to_s == 'SLASH_COMMENT')
    end
    return ftokens
  end
end
