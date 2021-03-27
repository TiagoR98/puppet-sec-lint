require_relative '../rule_engine'

class ConfigurationVisitor
  def self.Visit
    configurationsHash = {}

    rules = RuleEngine.rules
    rules.each do |rule|
      configurationsHash[rule] = []
      rule.configurations.each do |configuration|
        configurationsHash[rule].append(configuration)
      end
    end

    return configurationsHash
  end
end