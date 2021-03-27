require_relative 'configuration'

class ListConfiguration < Configuration

  def initialize(name, value, description)
    super
    @displayfield=DisplayField[:SelectBox]
  end
end