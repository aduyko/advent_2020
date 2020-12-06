# Validate that each input separated by a blank line contains each of "required_fields" in the format `field:value`

input_file = "inputs/4.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
end

required_fields = [
  "byr", 
  "iyr",
  "eyr",
  "hgt",
  "hcl",
  "ecl",
  "pid"
]

valid = 0
x = input[0]
input.each do |x|
  data = x.split("\n").join(" ").split()
  data = Hash[data.map { |entry| entry.split(":") }]
  valid +=1 if required_fields.all? { |field| data.key? field }
end

puts valid
