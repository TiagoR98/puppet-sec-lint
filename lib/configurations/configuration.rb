require 'securerandom'

class Configuration
  attr_accessor :name,:value,:description,:id,:displayfield

  def initialize(name, value, description)
    @name = name
    @value = value
    @description = description
    @id = SecureRandom.uuid
  end

end

DisplayField = {
  TextBox: "textbox",
  CheckBox: "checkbox",
  NumericBox: "numericbox",
  SelectBox: "selectbox"
}