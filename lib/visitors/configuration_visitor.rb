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

  def self.GenerateIDs
    configurationsHash = self.Visit

    configurationsHash.each do |rule,configurations|
      configurations.each do |configuration|
        configuration.id = "#{rule}-#{configuration.name.downcase.gsub! ' ', '_'}"
      end
    end
  end
end