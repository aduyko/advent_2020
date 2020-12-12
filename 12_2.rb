# Starting with ship at [0,0] and waypoint at [1,10], follow instructions and return manhattan coordinates of ship

input_file = "inputs/12.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map { |i| [i[0], i[1..-1].to_i] }
end

#E,N
coordinates = [0,0]
#E,N
waypoint = [10,1]

input.each do |instruction|
  action = instruction[0]
  value = instruction[1]
  case action
  when "N"
    waypoint[1] += value
  when "S"
    waypoint[1] -= value
  when "E"
    waypoint[0] += value
  when "W"
    waypoint[0] -= value
  when "L"
    direction = (value / 90) % 4
    direction.times do |i|
      waypoint = [-waypoint[1],waypoint[0]]
    end
  when "R"
    direction = (value / 90) % 4
    direction.times do |i|
      waypoint = [waypoint[1],-waypoint[0]]
    end
  when "F"
    value.times do |i|
      coordinates[0] += waypoint[0]
      coordinates[1] += waypoint[1]
    end
  end
end

puts coordinates.map { |n| n.abs }.reduce(:+)
