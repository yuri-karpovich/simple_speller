require "test_helper"

class YandexSpellerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::YandexSpeller::VERSION
  end

  def test_it_fix_errors
    incorrect = 'мама я в abkkbgbyf[ купила ferraru'
    correct = 'мама я в филиппинах купила ferrari'
    assert_equal YandexSpeller.fix(incorrect), correct
  end
end
