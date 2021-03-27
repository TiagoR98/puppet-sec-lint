require_relative 'visitor'
require_relative 'rule_engine'

class ConfigurationVisitor < Visitor
  def self.Visit
    result =""

    rules = RuleEngine.rules
    rules.each do |rule|
      rule.configurations.each do |configuration|
        result += "Rule #{rule.name} -> Configuration #{configuration.name}\n"
      end
    end

    return result
  end
end