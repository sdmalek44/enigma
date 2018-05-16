require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

def encrypt_file(filename, output_filename, offsets, rotations, enigma)
  input_file = File.open(filename, 'r')
  text = input_file.read.strip
  encrypted = enigma.encrypt(text, offsets, rotations)
  output_file = File.open(output_filename, 'w')
  output_file.write(encrypted)
  input_file.close
  output_file.close
end

message_file, new_filename = ARGV

keygen = KeyGenerator.new
key = keygen.random_key

rotations = keygen.get_rotations(key)

offset_calculator = OffsetCalculator.new

date = offset_calculator.todays_date

offsets = offset_calculator.get_offsets(date)

e = Enigma.new

encrypt_file(message_file, new_filename, offsets, rotations, e)

puts "Created #{new_filename} with the key #{key} and date #{date}"
