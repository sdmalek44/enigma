class Enigma

  def initialize
    @characters = (("a".."z").to_a << ("0".."9").to_a << [" ", ".", ","]).flatten
  end

  def get_offsets(time = Time.new.strftime("%m%e%y"))
    digits_arr = (time.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end

  def get_key
    ("1" .. "5").to_a.shuffle
  end

  def get_rotations(key = get_key)
    rotations = []
    rotations << (key[0] + key[1]).to_i
    rotations << (key[1] + key[2]).to_i
    rotations << (key[2] + key[3]).to_i
    rotations << (key[3] + key[4]).to_i
  end

  def total_rotation(offsets = get_offsets, rotations = get_rotations)
    total_rotation = []
    rotation_letters = ["A", "B", "C", "D"]
    total_rotation << offsets[0] + rotations[0]
    total_rotation << offsets[1] + rotations[1]
    total_rotation << offsets[2] + rotations[2]
    total_rotation << offsets[3] + rotations[3]
    Hash[rotation_letters.zip(total_rotation)]
  end

  def new_cipher(rotation)
    keys = @characters
    values = keys.rotate(rotation)
    keys.zip(values).to_h
  end
end
