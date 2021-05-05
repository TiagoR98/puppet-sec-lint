# frozen_string_literal: true

require "test_helper"

class InvalidIPAddrBindingRuleTest < Minitest::Test

  def test_it_detects_invalid_ip_add_binding_class
    code = "class test::service (
         $valid_ip = '192.168.23.15',
         $invalid_ip = '0.0.0.0'
      )"

    expected_result = [
      Sin.new(SinType::InvalidIPAddrBinding,3 , 10, 3, 31)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = InvalidIPAddrBindingRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect invalid IP addresses in classes")
  end

end
