require_relative 'configuration'

class BooleanConfiguration < Configuration

  def initialize(name, value, description)
    super
    @displayfield=DisplayField[:CheckBox]
  end

end