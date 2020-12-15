# To be honest I don't understand this one at all. I came close but no cigar, the math just didn't add up for me.
# If buses wait idx minutes to leave, at what timestamp after 0 will they all be lined up such that they leave idx minutes after each other?

input_file = "inputs/13.txt"
buses = []
File.open(input_file) do |f|
  input = f.read.split("\n")
  buses = input[1].split(",").map { |i| i.to_i if i != "x" }
end

timestamp = 0
step = 1
buses.each_with_index do |bus, offset|
  if bus.nil?
    next
  end
  until (timestamp + offset) % bus == 0 do
    timestamp += step
  end
  # I think the trick is that if any of the numbers do have common factors, they never sync up, they have to be relatively prime, so it wasn't intuitive to me that the minimum period length will therefore always be step * bus
  step = step * bus
end

puts timestamp
