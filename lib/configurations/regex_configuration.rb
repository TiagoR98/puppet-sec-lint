require_relative 'configuration'

class RegexConfiguration < Configuration

  def initialize(name, value, description)
    super
    @displayfield=DisplayField[:RegexBox]
  end
end