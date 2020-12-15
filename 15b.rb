# Next number in list = 0 if prior number new in list, index of prior - index of last appearance of prior otherwise
# Part 2 is just a bigger target - maybe there's a smart way to figure out if a sequence occurs? This is O(n) in any event, just uses a bunch of memory

input_file = "inputs/15.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split(",").map { |i| i.to_i }
end

target = 30000000
next_num = 0
next_index = input.length
last_indexes = Hash[input.collect { |i| [i,input.find_index(i)] }]

(target - input.length - 1).times do |i|
  num = next_num
  index = next_index
  if last_indexes.include? num
    next_num = index - last_indexes[num]
  else
    next_num = 0
  end
  last_indexes[num] = index
  next_index += 1
end

puts next_num
