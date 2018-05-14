require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

message_file, new_filename, key, date = ARGV

key = key.to_s

offsets = OffsetCalculator.new.get_offsets(date.to_s)

e = Enigma.new(key, offsets)

e.decrypt_file(message_file, new_filename)

puts "Created #{new_filename} with the key #{key} and date #{date}"
