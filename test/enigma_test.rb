require './test/test_helper'
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

  def test_new_rotations
    enigma = Enigma.new

    expected = [12, 23, 34, 45]
    actual = enigma.new_rotations("12345")

    assert_equal expected, actual
  end

  def test_it_returns_hash_of_rotations_plus_offsets
    enigma = Enigma.new
    offsets = [9, 2, 2, 4]
    rotations = [41, 12, 23, 35]

    actual = enigma.total_rotation(offsets, rotations)
    expected = {"A" =>50, "B" => 14, "C" => 25, "D" => 39}

    assert_equal expected, actual
  end

  def test_new_cipher_rotates_by_correct_rotation
    enigma = Enigma.new
    all_rotations = {"A" =>3, "B" => 2, "C" => 1, "D" => 4}
    cipher = enigma.new_cipher(all_rotations["A"])

    expected = "d"
    actual = cipher["a"]

    assert_equal expected, actual
  end

  def test_it_encrypts_message
    enigma = Enigma.new
    message = "Hello, World ..end.."

    actual = enigma.encrypt(message, "12345", "160518")
    expected = "\\$5B(FD-(15:4HR;'#R_"

    assert_equal expected, actual
  end

  def test_it_decrypts_message
    enigma = Enigma.new
    message = "\\$5B(FD-(15:"

    actual = enigma.decrypt(message, "12345", "160518")
    expected = "Hello, World"

    assert_equal expected, actual
  end


  def test_it_cracks
    enigma = Enigma.new

    actual = enigma.crack("Im+cPn5kHt=c:h4UI%Ky:s&y^", "160518")
    expected = "this is so secret ..end.."

    assert_equal expected, actual
  end

  def test_it_detects_correct_key
    enigma = Enigma.new

    message = "Im+cPn5kHt=c:h4UI%Ky:s&y^"
    date = "160518"
    expected = "40271"

    assert_equal expected, enigma.detect_key(message, date)
  end

  def test_base_rotations
    enigma = Enigma.new

    expected = [-6, -16, -70, -70]

    assert_equal expected, enigma.base_rotations("tttt")
  end

  def test_it_returns_absolute_values_of_neg_rotations_plus_offsets
    enigma = Enigma.new

    base_rotations = [-10, -10, -10, -10]
    offsets = [1, 2, 3, 4]

    expected = [9, 8 , 7, 6]
    actual = enigma.actual_rotations(base_rotations, offsets)

    assert_equal expected, actual
  end
end
