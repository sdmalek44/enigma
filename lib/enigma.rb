require './lib/key_generator.rb'
require './lib/offset_calculator.rb'

class Enigma

  attr_reader :characters

  def initialize
    @characters = (("a".."z").to_a << ("0".."9").to_a << [" ", ".", ","]).flatten
  end

  def new_offsets
    OffsetCalculator.new.get_offsets
  end

  def new_rotations
    new_key = KeyGenerator.new
    new_key.get_rotations(new_key.random_key)
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
    rotated_characters = @characters.rotate(rotation)
    @characters.zip(rotated_characters).to_h
  end

  def encrypt(message, offsets = new_offsets, rotations = new_rotations, switch = 1)
    abcd_rotations = total_rotation(offsets, rotations)
    message_arr = message.chars
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

  def decrypt(encrypted, key, date)
    assigned_key =  KeyGenerator.new(key)
    rotations = assigned_key.get_rotations(assigned_key.key)

    offsets = OffsetCalculator.new.get_offsets(date)

    encrypt(encrypted, offsets, rotations, -1)
  end

  def base_rotations(message)

   last_4 = message[-4..-1].chars
   assumed_4 = ["n","d",".","."]
   end_rotations = []

   last_4.each_index do |idx|
     end_rotations << @characters.index(assumed_4[idx]) - @characters.index(last_4[idx])
   end

   left_over = message.length % 4
   shift_end_rotations = 4 - left_over

   start_rotations = end_rotations.rotate(shift_end_rotations)
 end

 def crack(message)

  base_rotations = base_rotations(message)

  decrypted_message = encrypt(message, 0, base_rotations)
  end

  def derive_rotations(base_rotations, offsets)
    rotations = []
    base_rotations.each_with_index do |base_rotation, idx|
      if base_rotation - offsets[idx] < 0
        rotations << (base_rotation - offsets[idx] + @characters.length)
      else
        rotations << (base_rotation - offsets[idx])
      end
    end
    rotations
  end

  def detect_key(message, date)
    base_rotations = base_rotations(message)
    offsets = OffsetCalculator.new.get_offsets(date)

    actual_rotations = derive_rotations(base_rotations, offsets)

    key_parts = []
    actual_rotations.each_with_index do |rot, idx|
      if idx == 0
        key_parts << rot.to_s.rjust(1, "0")
      else
        double_digit = rot.to_s.rjust(1, "0")
        key_parts << double_digit[1]
      end
    end
    key_parts.join
  end
end
