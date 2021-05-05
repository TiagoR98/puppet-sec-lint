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

  def ==(other_object)
    @type == other_object.type && @begin_line == other_object.begin_line && @begin_char == other_object.begin_char && @end_line == other_object.end_line && @end_char == other_object.end_char
  end

end