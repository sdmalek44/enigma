require './lib/enigma'
require './lib/offset_calculator'

def crack_file(filename, output_filename, date, e)
  input_file = File.open(filename, 'r')
  text = input_file.read.strip
  cracked = e.crack(text, date)
  output_file = File.open(output_filename, 'w')
  output_file.write(cracked)
  input_file.close
  output_file.close
  key = e.detect_key(text, date)
end

message_file, new_filename, date = ARGV

e = Enigma.new

date = date.to_s

key = crack_file(message_file, new_filename, date, e)

puts "Created #{new_filename} with the cracked key #{key} and date #{date}"
