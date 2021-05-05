# frozen_string_literal: true

require "test_helper"

class NoHTTPRuleTest < Minitest::Test

  def test_it_detects_invalid_ip_add_binding_class
    code = "class test::service (
         $insecure_addr = 'http://fe.up.pt',
         $secure_addr = 'https://fe.up.pt'
      )"

    expected_result = [
      Sin.new(SinType::HttpWithoutTLS,2 , 27, 2, 42)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = NoHTTPRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect insecure HTTP without TLS addresses in classes")
  end

end
