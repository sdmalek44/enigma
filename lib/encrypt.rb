require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

def encrypt_file(filename, output_filename, key, date, enigma)
  input_file = File.open(filename, 'r')
  text = input_file.read.strip
  encrypted = enigma.encrypt(text, key, date)
  output_file = File.open(output_filename, 'w')
  output_file.write(encrypted)
  input_file.close
  output_file.close
end

message_file, new_filename = ARGV

keygen = KeyGenerator.new
key = keygen.random_key

e = Enigma.new

date = e.format_date(Date.today)

encrypt_file(message_file, new_filename, key, date, e)

puts "Created #{new_filename} with the key #{key} and date #{date}"
