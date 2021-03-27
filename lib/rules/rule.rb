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
end
