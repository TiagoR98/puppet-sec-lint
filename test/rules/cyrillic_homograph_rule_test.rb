# frozen_string_literal: true

require "test_helper"

class CyrillicHomographRuleTest < Minitest::Test

  def test_it_detects_cyrillic_char_url_class
    code = "class test::service (
         $cyrillic_url = 'http://www.googlе.com',
         $normal_url = 'http://www.google.com'
      )"

    expected_result = [
      Sin.new(SinType::CyrillicHomographAttack,2 , 26, 2, 47)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = CyrillicHomographAttack.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect addresses with Cyrillic characters in classes")
  end

end
