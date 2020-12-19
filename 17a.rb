# Skipping for now, this seems like a really boring problem

input_file = "inputs/17.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end
