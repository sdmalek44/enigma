require './lib/key_generator.rb'
require './lib/offset_calculator.rb'
require 'date'

class Enigma

  attr_reader :characters

  def initialize
    @characters = (" ".."z").to_a
  end

  def new_offsets(date)
    OffsetCalculator.new.get_offsets(format_date(date))
  end

  def format_date(date)
    date.strftime("%d%m%y")
  end

  def new_key
    new_key = KeyGenerator.new.random_key
  end

  def new_rotations(key)
    KeyGenerator.new.get_rotations(key)
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

  def encrypt(message, key = , date = Date.today, switch = 1)

    rotations = new_rotations
    offsets = new_offsets(date)
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

  def decrypt(encrypted, key, date = get_date)
    assigned_key = KeyGenerator.new(key)
    rotations = assigned_key.get_rotations(assigned_key.key)

    offsets = OffsetCalculator.new.get_offsets(date)

    encrypt(encrypted, offsets, rotations, -1)
  end

  def base_rotations(message)
   last_4 = message[-4..-1].chars
   assumed_4 = ["n","d",".","."]
   end_rotations = []

   last_4.each_index do |idx|
     new_char = @characters.rotate(@characters.index(assumed_4[idx]))
   end_rotations << - new_char.index(last_4[idx])
   end
   left_over = message.length % 4
   base_rotations = end_rotations.rotate(4 - left_over)
 end

 def crack(message)
  base_rotations = base_rotations(message)

  decrypted_message = encrypt(message, 0, base_rotations)
  end

  def actual_rotations(base_rotations, offsets)
    real_rotations = []
    base_rotations.each_with_index do |base, index|
      real_rotations << (base + offsets[index]).abs
    end
    real_rotations
  end

  def detect_key(message, date)
    base_rotations = base_rotations(message)
    offsets = OffsetCalculator.new.get_offsets(date)
    actual_rotations = actual_rotations(base_rotations, offsets)

    key_parts = []
    actual_rotations.each_with_index do |rot, idx|
      if idx == 0
        key_parts << rot.to_s.rjust(1, "0")
      else
        key_parts << rot.to_s[-1]
      end
    end
    key_parts.join
  end
end
