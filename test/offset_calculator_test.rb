require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset_calculator'

class OffsetCalculatorTest < Minitest::Test


  def test_format_date
    offset_calculator = OffsetCalculator.new

    assert_equal String, offset_calculator.format_date.class
    assert_equal 6, offset_calculator.format_date.length
  end

  def test_get_offsets
    offset_calculator = OffsetCalculator.new
    expected = [9, 9, 2, 4]
    actual = offset_calculator.get_offsets("051118")

    assert_equal expected, actual
  end
end
