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

    assert_equal 5, keygen.get_key.length
    assert_equal String, keygen.get_key.class 
  end
end
