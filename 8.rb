# Follow instructions - acc, add val to running total, jmp jumps val instructions, nop means just go forward 1
# Return value of acc immediately before the program loops and repeats an instruction
require 'set'

input_file = "inputs/8.txt"

# Format like this: [[instruction,value]]
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map(&:split)
  input.map { |i| i[1] = i[1].to_i }
end

visited = Set[]
acc = 0
idx = 0
until visited.include? idx do
  visited.add(idx)
  case input[idx][0]
  when 'acc'
    acc += input[idx][1]
    idx += 1
  when 'jmp'
    idx += input[idx][1]
  when 'nop'
    idx += 1
  end
end

puts acc
