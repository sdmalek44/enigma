require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new("key", "offsets")

    assert_instance_of Enigma, enigma
  end

  def test_it_gets_rotations
    enigma = Enigma.new("key", "offsets")

    expected = [12, 23, 34, 45]
    actual = enigma.get_rotations("12345")

    assert_equal expected, actual
  end

  def test_it_returns_hash_of_rotations_plus_offsets
    enigma = Enigma.new("key", "offsets")
    offsets = [9, 2, 2, 4]
    rotations = [41, 12, 23, 35]

    actual = enigma.total_rotation(offsets, rotations)
    expected = {"A" =>50, "B" => 14, "C" => 25, "D" => 39}

    assert_equal expected, actual
  end

  def test_new_cipher_rotates_by_correct_rotation
    enigma = Enigma.new("key", "offsets")
    all_rotations = {"A" =>3, "B" => 2, "C" => 1, "D" => 4}
    cipher = enigma.new_cipher(all_rotations["A"])

    expected = "d"
    actual = cipher["a"]

    assert_equal expected, actual
  end

  def test_encrypt
    enigma = Enigma.new("12345", [9, 2, 2, 4])

    expected = "23iv9wty, ai"
    actual = enigma.encrypt("hello world.")

    assert_equal expected, actual
  end

  def test_decrypt_encrypts_by_negative_rotation
    enigma = Enigma.new("12345", [9, 2, 2, 4])

    expected = "hello world."
    actual = enigma.decrypt("23iv9wty, ai")

    assert_equal expected, actual
  end

  def test_it_cracks
    enigma = Enigma.new("12345", [9, 2, 2, 4])

    actual = enigma.crack("b6f2s7phvwjoae qzw8iz,ait")
    expected = "this is a message ..end.."

    assert_equal expected, actual
  end

  def test_detects_correct_key
    enigma = Enigma.new("12345", [9, 2, 2, 4])
    total_rotations = [53, 25, 34, 18]
    offsets = [1, 2, 3, 4]

    actual = enigma.detect_key(total_rotations, offsets)
    expected = "52314"

    assert_equal expected, actual
  end
end
