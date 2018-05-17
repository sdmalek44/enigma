require './test/test_helper'
require './lib/offset_calculator'

class OffsetCalculatorTest < Minitest::Test
  def test_get_offsets_with_passed_in_date
    offset_calculator = OffsetCalculator.new
    expected = [9, 9, 2, 4]
    actual = offset_calculator.get_offsets("051118")

    assert_equal expected, actual
  end
end
