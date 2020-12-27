# find card loop size by starting with 1, multiplying by 7 and modulo 20201227 until you get the card_pub_key value
# Then start with 1, multiply by door pub key and modulo 202012227 card loop size times
# Can flip card and door for finding loop and result value
input_file = "inputs/25.txt"
card_pub_key = 0
door_pub_key = 0
subject_number = 7

File.open(input_file) do |f|
  input = f.read.split("\n")
  card_pub_key = input[0].to_i
  door_pub_key = input[1].to_i
end

card_loop_size = 0
card_value = 1
until card_value == card_pub_key
  card_value = card_value * subject_number
  card_value = card_value % 20201227
  card_loop_size += 1
end

value = 1
card_loop_size.times do |i|
  value = value * door_pub_key
  value = value % 20201227
end

p value
