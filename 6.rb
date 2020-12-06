# Separating the input by blank line, find how many characters appear in each line per group

input_file = "inputs/6.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
end

sum_counts = 0
input.each do |x|
  sum_counts += x.delete("\n").chars.uniq.length
end

puts sum_counts
