require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'


class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_new_key
    enigma = Enigma.new
    enigma.new_key

    assert_equal 1, enigma.key.count(1)
    assert_equal 1, enigma.key.count(2)
    assert_equal 1, enigma.key.count(3)
    assert_equal 1, enigma.key.count(4)
    assert_equal 1, enigma.key.count(5)
  end

  def test_it_returns_offset_digits
    enigma = Enigma.new
    actual = enigma.offset_digits
    expected = [9, 9, 2, 4]
  end
end
