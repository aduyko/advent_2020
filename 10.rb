# Figure out how many 1 and 3 point differences there are between all the given values, 0, and max[values]+3

input_file = "inputs/10.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map(&:to_i).sort
end

differences = [0,0,0,1]
previous = 0
input.each do |n|
  diff = n - previous
  previous = n
  differences[diff] += 1
end

puts differences[1] * differences[3]
