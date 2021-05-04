class Sin
  attr_accessor :type,:begin_line,:begin_char,:end_line,:end_char

  def initialize(type, begin_line, begin_char, end_line, end_char)
    @type = type
    @begin_line = begin_line
    @begin_char = begin_char
    @end_line = end_line
    @end_char = end_char
  end

  def ToString
    return "<Sin:#{@type[:name]}, Line:#{@begin_line}, Char:#{@begin_char}, Message:#{@type[:message]}, Recommendation:#{@type[:solution]}>"
  end
end