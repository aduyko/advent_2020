# get the bus that will come soonest after timestamp if buses come every x tics

input_file = "inputs/13.txt"
buses = []
timestamp = 0
File.open(input_file) do |f|
  input = f.read.split("\n")
  timestamp = input[0].to_i
  buses = input[1].split(",").reject { |i| i == "x" }.map(&:to_i)
end

soonest = 999999999
soonest_id = 0
buses.each do |bus|
  time_until = bus - (timestamp % bus)
  if time_until < soonest
    soonest = time_until
    soonest_id = bus
  end
end

print soonest * soonest_id
