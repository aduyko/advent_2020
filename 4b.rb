# Validate that each input separated by a blank line contains each of "required_fields" in the format `field:value` and also validate that value, bunch of rules for what those validations should be but they're basically what I put in my solution below

input_file = "inputs/4.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
end

def validate_height(field)
end

required_fields = {
  "byr" => lambda { |x| x.to_i.between?(1920,2002) },
  "iyr" => lambda { |x| x.to_i.between?(2010,2020) },
  "eyr" => lambda { |x| x.to_i.between?(2020,2030) },
  "hgt" => lambda do |x|
    fields = x.scan(/(\d+)(cm|in)/)
    return false if fields.length != 1
    return false if fields[0].length != 2
    fields = fields[0]
    if fields[1]=="cm"
      return true if fields[0].to_i.between?(150,193)
    elsif fields[1]=="in"
      return true if fields[0].to_i.between?(59,76)
    end
    return false
  end,
  "hcl" => lambda { |x| x.match?(/#[\da-f]{6}/) },
  "ecl" => lambda { |x| x.match?(/(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)/) },
  "pid" => lambda { |x| x.match?(/^\d{9}$/) }
}

valid = 0
x = input[0]
input.each do |x|
  data = x.split("\n").join(" ").split()
  data = Hash[data.map { |entry| entry.split(":") }]
  data_valid = true
  required_fields.each do |field,func|
    unless data.key? field
      data_valid = false
      break
    end
    unless func.call(data[field])
      data_valid = false
      break
    end
  end
  valid += 1 if data_valid
end

puts valid
