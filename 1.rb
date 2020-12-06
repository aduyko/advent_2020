# Find only two values in input that add up to 2020, return their product

input_file = "inputs/1.txt"
input = ""
numbers = {}
File.open(input_file) do |f|
  input = f.read
  nums = input.split("\n")
  numbers = Hash[input.split("\n").map(&:to_i).collect { |item| [item,1] }]
end

numbers.each do |k,v|
  if numbers.key?(2020-k)
    puts k
    puts k*(2020-k)
  end
end
