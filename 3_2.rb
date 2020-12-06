# assuming input continues infinitely horizontally, how many # do you land on if you start at 0,0 and transpose [1,-1], [3,-1], [5,-1], [7,-1], [1,-2] moving horizontally down to the last line of input? Multiply that number for the result obtained for each set of transpositions

input_file = "inputs/3.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

offsets = [1,3,5,7,1]
offset = Array.new(5,0)
trees = Array.new(5,0)
input.each_with_index do |row,idx|
  offset.each_with_index do |o,oidx|
    next if oidx == 4 and idx % 2 != 0
    if row[offset[oidx]] == "#"
      trees[oidx] += 1
    end
    offset[oidx] = (offset[oidx] + offsets[oidx]) % (row.length)
  end
end

puts trees.reduce(:*)
