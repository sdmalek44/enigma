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

    assert_equal 1, enigma.get_key.count("1")
    assert_equal 1, enigma.get_key.count("2")
    assert_equal 1, enigma.get_key.count("3")
    assert_equal 1, enigma.get_key.count("4")
    assert_equal 1, enigma.get_key.count("5")
  end

  def test_it_returns_offset_digits
    enigma = Enigma.new

    assert_equal 4, enigma.offset_digits.length
    assert_equal Integer, enigma.offset_digits.sample.class
    assert_equal Array, enigma.offset_digits.class
  end

  def test_it_gets_rotations
    enigma = Enigma.new
    assert_equal 4, enigma.get_rotations.length
    assert_equal Integer, enigma.get_rotations.sample.class
    assert_equal Array, enigma.get_rotations.class
  end
end
