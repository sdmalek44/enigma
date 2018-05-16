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
    rotations = [35, 55, 57, 70]

    expected = "lx5hsqdkv4x7"
    actual = enigma.encrypt("hello world.", offsets, rotations)

    assert_equal expected, actual
  end

  def test_decrypt_encrypts_by_negative_rotation
    enigma = Enigma.new
    key = "35570"
    date = "150518"

    expected = "hello world."
    actual = enigma.decrypt("lx5hsqdkv4x7", key, date)

    assert_equal expected, actual
  end

  def test_it_cracks
    enigma = Enigma.new

    actual = enigma.crack("b6f2s7phvwjoae qzw8iz,ait")
    expected = "this is a message ..end.."

    assert_equal expected, actual
  end

  def test_detects_correct_key
    skip
    enigma = Enigma.new
    message = "v8kjq0cyqu8rt,qfzy8drylirs"
    date = "150518"

    actual = enigma.detect_key(message, date)
    expected = "11740"

    assert_equal expected, actual
  end
end
