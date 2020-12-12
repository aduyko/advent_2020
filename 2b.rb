# Input format:
# pos_1-pos_2 target: string_to_check
# Validate that target appears in string_to_check either at pos_1 or pos_2 but not at both

input_file = "inputs/2.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

valid = 0
input.each do |x|
  x = x.split(":")
  x_0 = x[0].split(" ")
  target_range = x_0[0].split("-").map(&:to_i)
  target_letter = x_0[1]
  password = x[1]
  password[0] = ''
  if (password[target_range[0]-1]==target_letter) ^ (password[target_range[1]-1]==target_letter)
    valid+=1
  end
end

puts valid
