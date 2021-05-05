# frozen_string_literal: true

require "test_helper"

class UseWeakCryptoAlgorithmsRuleTest < Minitest::Test

  def test_it_detects_use_weak_crypto_algorithms_class
    code = "class test::service (
         $password_hash = md5('password1234'),
         $secure_password_hash = sha256('password1234')
      )"

    expected_result = [
      Sin.new(SinType::WeakCryptoAlgorithm,2 , 27, 2, 30)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = UseWeakCryptoAlgorithmsRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect the use of weak crypto algorithms in a class")
  end

end
