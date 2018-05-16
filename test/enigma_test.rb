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

  def test_new_cipher_rotates_by_correct_rotation
    enigma = Enigma.new
    all_rotations = {"A" =>3, "B" => 2, "C" => 1, "D" => 4}
    cipher = enigma.new_cipher(all_rotations["A"])

    expected = "d"
    actual = cipher["a"]

    assert_equal expected, actual
  end

  def test_encrypt
    enigma = Enigma.new
    offsets = [8,3,2,4]
    rotations = [12, 23, 34, 45]

    expected = "!$5B(:@E++-_"
    actual = enigma.encrypt("hello world.", offsets, rotations)

    assert_equal expected, actual
  end

  def test_decrypt_encrypts_by_negative_rotation
    enigma = Enigma.new
    key = "12345"
    date = "150518"

    expected = "hello world."
    actual = enigma.decrypt("!$5B(:@E++-_", key, date)

    assert_equal expected, actual
  end

  def test_it_cracks
    enigma = Enigma.new

    actual = enigma.crack("ob%*vc/2ni7*`].wouE@`h @)")
    expected = "this is so secret ..end.."

    assert_equal expected, actual
  end

  def test_detects_correct_key
    enigma = Enigma.new
    message = "ob%*vc/2ni7*`].wouE@`h @)"
    date = "160518"

    actual = enigma.detect_key(message, date)
    expected = "78214"

    assert_equal expected, actual
  end
end
