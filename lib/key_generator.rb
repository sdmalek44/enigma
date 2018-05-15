class KeyGenerator

  attr_reader :key

  def initialize(key = "12345")
   @key = key
  end

  def random_key
    rand(00000..99999).to_s.rjust(5, "0")
  end

  def get_rotations(key)
    key = key.chars
    rotations = []
    rotations << (key[0] + key[1]).to_i
    rotations << (key[1] + key[2]).to_i
    rotations << (key[2] + key[3]).to_i
    rotations << (key[3] + key[4]).to_i
  end
end
