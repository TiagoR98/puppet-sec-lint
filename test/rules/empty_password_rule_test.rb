# frozen_string_literal: true

require "test_helper"

class EmptyPasswordRuleTest < Minitest::Test

  def test_it_detects_empty_password_class
    code = "class test::service (
         $password = 'secure_pass1234',
         $empty_password = '',
         $random_empty_value = ''
      )"

    expected_result = [
      Sin.new(SinType::EmptyPassword,3 , 26, 3, 28)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = EmptyPasswordRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect empty passwords in classes")
  end

end
