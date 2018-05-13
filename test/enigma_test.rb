require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_format_date
    enigma = Enigma.new

    assert_equal String, enigma.format_date.class
    assert_equal 6, enigma.format_date.length
  end

  def test_get_offsets
    enigma = Enigma.new
    expected = [9, 9, 2, 4]
    actual = enigma.get_offsets("051118")

    assert_equal expected, actual
  end

  def test_it_gets_rotations
    enigma = Enigma.new

    expected = [12, 23, 34, 45]
    actual = enigma.get_rotations("12345")

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

  def test_encryptor
    enigma = Enigma.new

    expected = "w6iv3zty6aai"
    actual = enigma.encryptor("hello world.", "12345", "051218")

    assert_equal expected, actual
  end

  def test_decryptor
    enigma = Enigma.new

    expected = "hello world."
    actual = enigma.decryptor("w6iv3zty6aai", "12345", "051218")

    assert_equal expected, actual
  end
end
