# I kept getting confused about the prompt for this one, and got confused looking for a more math-y solution calculating phases. I resorted to peeking online to figure it out.
# At what timestamp will all the buses be lined up such that they leave idx minutes after each other?

input_file = "inputs/13.txt"
buses = []
File.open(input_file) do |f|
  input = f.read.split("\n")
  buses = input[1].split(",").map { |i| i.to_i if i != "x" }
end

timestamp = 0
step = 1
buses.each_with_index do |bus, offset|
  next if bus.nil? # Skip 'x'
  # timestamp here is always going to be when all prior buses are in sync
  until (timestamp + offset) % bus == 0 do
    timestamp += step
  end
  # step = new LCM // buses will always be relatively prime
  step = step * bus
end

puts timestamp
