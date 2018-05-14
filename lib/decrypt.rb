require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

def decrypt_file(file_name, new_filename, enigma)
  input_file = File.open(file_name, 'r')
  text = input_file.read.strip
  decrypted = enigma.decrypt(text)
  output_file = File.open(new_filename, 'w')
  output_file.write(decrypted)
  input_file.close
  output_file.close
end

message_file, new_filename, key, date = ARGV

key = key.to_s

offsets = OffsetCalculator.new.get_offsets(date.to_s)

e = Enigma.new(key, offsets)

decrypt_file(message_file, new_filename, e)

puts "Created #{new_filename} with the key #{key} and date #{date}"
