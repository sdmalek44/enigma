require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test

  def test_it_exists
    keygen = KeyGenerator.new

    assert_instance_of KeyGenerator, keygen
  end

  def test_get_key
    keygen = KeyGenerator.new
    expected = "12345"
    actual = keygen.get_key(["1", "2", "3", "4", "5"])

    assert_equal expected, actual
  end
end
