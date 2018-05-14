require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

def encrypt_file(filename, output_filename, enigma)
  input_file = File.open(filename, 'r')
  text = input_file.read.strip
  encrypted = enigma.encrypt(text)
  output_file = File.open(output_filename, 'w')
  output_file.write(encrypted)
  input_file.close
  output_file.close
end

message_file, new_filename = ARGV

key = KeyGenerator.new.get_key

offset_calculator = OffsetCalculator.new

date = offset_calculator.format_date

offsets = offset_calculator.get_offsets

e = Enigma.new(key, offsets)

encrypt_file(message_file, new_filename, e)

puts "Created #{new_filename} with the key #{key} and date #{date}"
