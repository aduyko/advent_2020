# Input format:
# min_occurences-max_occurences target: string_to_check
# Validate that target appears in string_to_check between min and max occurences times

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
  if password.count(target_letter).between?(target_range[0],target_range[1])
    valid+=1
  end
end

puts valid
