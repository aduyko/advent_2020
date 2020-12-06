# Find only three values in input that add up to 2020, return their product

input_file = "inputs/1.txt"
input = ""
numbers = {}
File.open(input_file) do |f|
  input = f.read
  nums = input.split("\n")
  numbers = Hash[input.split("\n").map(&:to_i).collect { |item| [item,1] }]
end

product = 0
numbers.each do |k,v|
  first = k
  numbers.delete(k)
  numbers.each do |k,v|
    running_sum = first + k
    if numbers.key?(2020-running_sum)
      product = first*k*(2020-running_sum)
      break
    end
  end
  break if product > 0
end

puts product
