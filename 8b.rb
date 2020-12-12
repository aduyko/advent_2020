# Follow instructions - acc, add val to running total, jmp jumps val instructions, nop means just go forward 1
# Program terminates after running last instruction - switch one jmp to nop or one nop to jump to accomplish this
require 'set'

input_file = "inputs/8.txt"

# Format like this: [[instruction,value]]
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map(&:split)
  input.map { |i| i[1] = i[1].to_i }
end

def backtrack(visited,acc,idx,input,swapped)
  return -1 if visited.include? idx
  return acc if idx == input.length
  visited.add(idx)
  command = input[idx][0]
  command_val = input[idx][1]

  case command
  when 'acc'
    return backtrack(visited,acc+command_val,idx+1,input,swapped)

  when 'nop'
    result = backtrack(visited,acc,idx+1,input,swapped)
    if result == -1
      if not swapped # run this command as a jmp, set swapped to true
        swapped = true
        return backtrack(visited,acc,idx+command_val,input,swapped)
      end
    end

  when 'jmp'
    result = backtrack(visited,acc,idx+command_val,input,swapped)
    if result == -1
      if not swapped # run this command as a nop, set swapped to true
        swapped = true
        return backtrack(visited,acc,idx+1,input,swapped)
      end
    end
  end

  return result
end

visited = Set[]
acc = 0
idx = 0
swapped = false

result = backtrack(visited,acc,idx,input,swapped)
puts result
