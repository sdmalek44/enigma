require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test
  def test_it_exists
    keygen = KeyGenerator.new

    assert_instance_of KeyGenerator, keygen
  end

  def test_random_key
    keygen = KeyGenerator.new

    assert_equal 5, keygen.random_key.length
    assert_equal String, keygen.random_key.class
  end

  def test_it_assigns_key
    keygen = KeyGenerator.new('12345')

    expected = '12345'
    actual = keygen.key

    assert_equal expected, actual
  end

  def test_finds_rotations_from_key
    keygen = KeyGenerator.new('12345')

    expected = [12, 23, 34, 45]
    actual = keygen.get_rotations

    assert_equal expected, actual
  end
end
