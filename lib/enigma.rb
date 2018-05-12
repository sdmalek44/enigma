
class Enigma

  attr_reader :characters

  def initialize
    @characters = (("a".."z").to_a << ("0".."9").to_a << [" ", ".", ","]).flatten
  end

  def format_date(time = Time.new)
     date = time.strftime("%m%e%y")
  end

  def get_offsets(date)
    digits_arr = (date.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end

  def get_key
    ("1" .. "5").to_a.shuffle.join
  end

  def get_rotations(key)
    key = key.split("")
    rotations = []
    rotations << (key[0] + key[1]).to_i
    rotations << (key[1] + key[2]).to_i
    rotations << (key[2] + key[3]).to_i
    rotations << (key[3] + key[4]).to_i
  end

  def total_rotation(offsets, rotations)
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

  def encryptor(message, key = get_key, date = format_date, switch = 1)
    rotations = get_rotations(key)
    offsets = get_offsets(date)
    abcd_rotations = total_rotation(offsets, rotations)

    message_arr = message.split("")
    encrypted_arr = []

    message_arr.each_with_index do |char, index|
      if index % 4 == 0
        cipher = new_cipher(abcd_rotations["A"]*switch)
        encrypted_arr << cipher[char]
      elsif index % 4 == 1
        cipher = new_cipher(abcd_rotations["B"]*switch)
        encrypted_arr << cipher[char]
      elsif index % 4 == 2
        cipher = new_cipher(abcd_rotations["C"]*switch)
        encrypted_arr << cipher[char]
      elsif index % 4 == 3
        cipher = new_cipher(abcd_rotations["D"]*switch)
        encrypted_arr << cipher[char]
      end
    end
    encrypted_arr.join
  end

  def decryptor(encrypted, key, date, switch = -1)
    encryptor(encrypted, key, date, switch)
  end

end
