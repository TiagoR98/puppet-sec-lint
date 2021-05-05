# frozen_string_literal: true

require "test_helper"

class AdminByDefaultRuleTest < Minitest::Test

  def test_it_detects_admin_default_class
    code = "class test::service (
         $username = 'admin',
         $package = 'admin'
      )"

    expected_result = [
      Sin.new(SinType::AdminByDefault,2 , 10, 200, 27)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = AdminByDefaultRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect admin by default accounts in classes")
  end

end
