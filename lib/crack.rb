require './lib/enigma'
require './lib/offset_calculator'

def crack_file(filename, output_filename, enigma)
  input_file = File.open(filename, 'r')
  text = input_file.read.strip
  cracked = enigma.crack(text)
  output_file = File.open(output_filename, 'w')
  output_file.write(cracked)
  input_file.close
  output_file.close
end

message_file, new_filename, date = ARGV

e = Enigma.new

date = date.to_s

crack_file(message_file, new_filename, e)

puts "Created #{new_filename} with the cracked key unknown and date #{date}"
