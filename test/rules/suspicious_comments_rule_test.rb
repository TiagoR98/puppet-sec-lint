# frozen_string_literal: true

require "test_helper"

class SuspiciousCommentsRuleTest < Minitest::Test

  def test_it_detects_suspicious_comments
    code = "# very critical bug here
    class test::service (
         $random_property = 'no'
      )
    # regular comment"

    expected_result = [
      Sin.new(SinType::SuspiciousComments,1 , 1, 1, 24)
    ]

    lexer = PuppetLint::Lexer.new
    tokens = lexer.tokenise(code)

    actual_result = SuspiciousCommentRule.AnalyzeTokens(tokens)

    assert_equal(actual_result,expected_result,"It can't properly detect suspicious comments")
  end

end
