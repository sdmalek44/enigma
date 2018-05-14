class Enigma

  attr_reader :characters

  def initialize(key = "12345", offsets = [9, 2, 2, 4])
    @characters = (("a".."z").to_a << ("0".."9").to_a << [" ", ".", ","]).flatten
    @key = key
    @offsets = offsets
  end

  def get_rotations(key = @key)
    key = key.split("")
    rotations = []
    rotations << (key[0] + key[1]).to_i
    rotations << (key[1] + key[2]).to_i
    rotations << (key[2] + key[3]).to_i
    rotations << (key[3] + key[4]).to_i
  end

  def total_rotation(offsets = @offsets, rotations = get_rotations)
    total_rotation = []
    rotation_letters = ["A", "B", "C", "D"]
    total_rotation << offsets[0] + rotations[0]
    total_rotation << offsets[1] + rotations[1]
    total_rotation << offsets[2] + rotations[2]
    total_rotation << offsets[3] + rotations[3]
    Hash[rotation_letters.zip(total_rotation)]
  end

  def new_cipher(rotation)
    rotated_characters = @characters.rotate(rotation)
    @characters.zip(rotated_characters).to_h
  end

  def encrypt(message, switch = 1, abcd_rotations = total_rotation(@offsets, get_rotations))
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

  def decrypt(encrypted, switch = -1)
    encrypt(encrypted, switch)
  end

  def crack(message)
    reversed_last_4 = message.split("").pop(4).reverse
    assumed_4 = [".",".","d","n"]
    rotations = []

    reversed_last_4.each_index do |idx|
      rotations << @characters.index(assumed_4[idx]) - @characters.index(reversed_last_4[idx])
    end

    abcd_rotations = total_rotation(0, rotations)

    reversed_decrypted_message = encrypt(message.reverse, 1, abcd_rotations)

    reversed_decrypted_message.reverse
  end

  def encrypt_file(filename, output_filename)
    input_file = File.open(filename, 'r')
    text = input_file.read.strip
    encrypted = encrypt(text)
    output_file = File.open(output_filename, 'w')
    output_file.write(encrypted)
    input_file.close
    output_file.close
  end
end
