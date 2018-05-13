require './lib/enigma'
require './lib/key_generator'
require './lib/offset_calculator'

message_file, new_filename = ARGV

key = KeyGenerator.new.get_key

offset_calculator = OffsetCalculator.new

date = offset_calculator.format_date

offsets = offset_calculator.get_offsets

e = Enigma.new(key, offsets)

e.encrypt_file(message_file, new_filename)

puts "Created #{new_filename} with the key #{key} and date #{date}"
