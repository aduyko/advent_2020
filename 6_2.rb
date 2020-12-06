# Separating the input by blank line, find how many characters appear in every line

input_file = "inputs/6.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
end

sum_counts = 0
input.each do |group|
  n = group.split("\n").length
  chars = group.delete("\n").chars.sort.join
  l = chars.scan(/(.)\1{#{n-1},}/)
  sum_counts += l.length
end

puts sum_counts
