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
    assert_equal Array, enigma.get_key.class
  end

  def test_it_returns_offset_digits
    enigma = Enigma.new
    expected = [9, 9, 2, 4]
    actual = enigma.get_offsets("051118")

    assert_equal expected, actual
  end

  def test_it_gets_rotations
    enigma = Enigma.new

    expected = [12, 23, 34, 45]
    actual = enigma.get_rotations(["1", "2", "3", "4", "5"])

    assert_equal expected, actual
  end

  def test_total_rotations
    enigma = Enigma.new
    offsets = [9, 2, 2, 4]
    rotations = [41, 12, 23, 35]

    actual = enigma.total_rotation(offsets, rotations)
    expected = {"A" =>50, "B" => 14, "C" => 25, "D" => 39}

    assert_equal expected, actual
  end

  def test_new_cipher
    enigma = Enigma.new
    all_rotations = {"A" =>3, "B" => 2, "C" => 1, "D" => 4}
    cipher = enigma.new_cipher(all_rotations["A"])

    expected = "d"
    actual = cipher["a"]

    assert_equal expected, actual
  end
end
