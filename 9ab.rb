# Figure out if any combination of two numbers for every subset of 25 does not add up to the number following the 25
require 'set'

input_file = "inputs/9.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map(&:to_i)
end

def sum_exists?(set, sum)
  set.each do |n|
    return true if set.include? sum - n
  end
  return false
end

subset_length = 25
target_number = 0
(input.length - subset_length).times do |idx|
  target = input[idx+subset_length]
  sum_exists = sum_exists?(Set.new(input[idx,subset_length]),target)
  if not sum_exists
    target_number = target
    break
  end
end

puts target_number

encryption_weakness = 0
input.each_with_index do |i,idx|
  running_sum = 0
  contiguous_set = []
  until running_sum >= target_number do
    running_sum += input[idx]
    contiguous_set << input[idx]
    idx += 1
  end
  if running_sum == target_number and contiguous_set.length > 1
    encryption_weakness = contiguous_set.min + contiguous_set.max
    break
  end
end

puts encryption_weakness
