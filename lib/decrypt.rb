require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

def decrypt_file(file_name, new_filename, key, date, enigma)
  input_file = File.open(file_name, 'r')
  text = input_file.read.strip
  decrypted = enigma.decrypt(text, key, date)
  output_file = File.open(new_filename, 'w')
  output_file.write(decrypted)
  input_file.close
  output_file.close
end

message_file, new_filename, key, date = ARGV

key = key.to_s

date = date.to_s

e = Enigma.new

decrypt_file(message_file, new_filename, key, date, e)

puts "Created #{new_filename} with the key #{key} and date #{date}"
