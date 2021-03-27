class Configuration
  attr_accessor :name,:value,:description,:displayfield

  def initialize(name, value, description)
    @name = name
    @value = value
    @description = description
  end

end

DisplayField = {
  TextBox: "textbox",
  CheckBox: "checkbox",
  NumericBox: "numericbox",
  SelectBox: "selectbox"
}