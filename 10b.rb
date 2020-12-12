# Figure out how many ways there are to make jumps of sizes between 1 and 3 from 0 to the max of the input list
require 'set'

input_file = "inputs/10.txt"
input = []
File.open(input_file) do |f|
  input = Set.new(f.read.split("\n").map(&:to_i))
end

$searched = {}
def get_chains(element,list)
  return 1 if element == list.max
  ways = 0
  [1,2,3].each do |n|
    if list.member? element + n
      if $searched.key? element + n
        ways += $searched[element + n]
      else
        ways += get_chains(element + n, list)
      end
    end
  end
  $searched[element] = ways
  return ways
end

puts get_chains(0, input)
