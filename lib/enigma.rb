require './lib/key_generator'
require './lib/offset_calculator'
require 'date'

class Enigma
  attr_reader :characters

  def initialize
    @characters = (' '..'z').to_a
  end

  def new_offsets(date)
    OffsetCalculator.new.get_offsets(date)
  end

  def format_date(date)
    date.strftime('%d%m%y')
  end

  def new_key
    KeyGenerator.new.random_key
  end

  def new_rotations(key)
    KeyGenerator.new.get_rotations(key)
  end

  def total_rotation(offsets, rotations)
    total_rotation = []
    rotation_letters = %w[A B C D]
    rotations.each_index do |index|
      total_rotation << offsets[index] + rotations[index]
    end
    Hash[rotation_letters.zip(total_rotation)]
  end

  def new_cipher(rotation)
    rotated_characters = @characters.rotate(rotation)
    @characters.zip(rotated_characters).to_h
  end

  def encrypt(message, key = new_key, date = Date.today, switch = 1)
    date = format_date(date) if date.class == Date
    abcd = total_rotation(new_offsets(date), new_rotations(key))
    message.chars.map.with_index do |char, index|
      if (index % 4).zero?
        new_cipher(abcd['A'] * switch)[char]
      elsif index % 4 == 1
        new_cipher(abcd['B'] * switch)[char]
      elsif index % 4 == 2
        new_cipher(abcd['C'] * switch)[char]
      elsif index % 4 == 3
        new_cipher(abcd['D'] * switch)[char]
      end
    end.join
  end

  def decrypt(encrypted, key, date = Date.today)
    encrypt(encrypted, key, date, -1)
  end

  def crack(message, date = Date.today)
    date = format_date(date) if date.class == Date
    key = detect_key(message, date)
    decrypt(message, key, date)
  end

  def detect_key(message, date)
    actual = actual_rotations(base_rotations(message), new_offsets(date))
    key_parts = []
    actual.each_with_index do |rot, idx|
      if idx.zero?
        key_parts << rot.to_s.rjust(1, '0')
      else
        key_parts << rot.to_s[-1]
      end
    end
    key_parts.join
  end

  def base_rotations(message)
    last_four = message[-4..-1].chars
    assumed_four = %w[n d . .]
    end_rotations = []

    last_four.each_index do |idx|
      new_char = @characters.rotate(@characters.index(assumed_four[idx]))
      end_rotations << - new_char.index(last_four[idx])
    end
    shift_rotations(message, end_rotations)
  end

  def shift_rotations(message, end_rotations)
    left_over = message.length % 4
    end_rotations.rotate(4 - left_over)
  end

  def actual_rotations(base_rotations, offsets)
    real_rotations = []
    base_rotations.each_with_index do |base, index|
      real_rotations << (base + offsets[index]).abs
    end
    real_rotations
  end
end
