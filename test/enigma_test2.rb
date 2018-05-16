require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_returns_hash_of_rotations_plus_offsets
    enigma = Enigma.new
    offsets = [9, 2, 2, 4]
    rotations = [41, 12, 23, 35]

    actual = enigma.total_rotation(offsets, rotations)
    expected = {"A" =>50, "B" => 14, "C" => 25, "D" => 39}

    assert_equal expected, actual
  end

  def test_returns_characters
    enigma = Enigma.new

    assert_equal 91, enigma.characters.length
    assert_equal String, enigma.characters.sample.class
  end

  def test_new_offsets
    enigma = Enigma.new

    actual = enigma.new_offsets("160518")
    expected = [8, 3, 2, 4]

    assert_equal expected, actual
  end

  def test_format_date
    enigma = Enigma.new

    assert_equal 6, enigma.format_date(Date.today).length
    assert_equal String, enigma.format_date(Date.today).class
  end

  def test_new_key
    enigma = Enigma.new

    assert_equal 5, enigma.new_key.length
    assert_equal String, enigma.new_key.class
  end

end
