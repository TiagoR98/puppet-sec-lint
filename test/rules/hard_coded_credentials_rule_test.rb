# frozen_string_literal: true

require "test_helper"

class HardCodedCredentialsRuleTest < Minitest::Test

  def test_it_detects_hard_coded_passwords_class
    code = "class test::service (
         $o_pass = 'secret_pass'
      )"

    expected_result = [
      Sin.new(SinType::HardCodedCred,2 , 10, 2, 31)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = HardCodedCredentialsRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect hard coded passwords in classes")
  end

end
