# assuming input continues infinitely horizontally, how many # do you land on if you start at 0,0 and transpose 3,-1 moving horizontally down to the last line of input?

input_file = "inputs/3.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

offset = 0
trees = 0
input.each do |x|
  if x[offset] == "#"
    trees += 1
  end
  offset = (offset += 3) % (x.length)
end

puts trees
