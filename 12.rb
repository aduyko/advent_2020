# Starting facing east, follow instructions and return manhattan coordinates

input_file = "inputs/12.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map { |i| [i[0], i[1..-1].to_i] }
end

#E,N
coordinates = [0,0]
#N,E,S,W
direction = 1

input.each do |instruction|
  action = instruction[0]
  value = instruction[1]
  case action
  when "N"
    coordinates[1] += value
  when "S"
    coordinates[1] -= value
  when "E"
    coordinates[0] += value
  when "W"
    coordinates[0] -= value
  when "L"
    direction = (direction - (value / 90)) % 4
  when "R"
    direction = (direction + (value / 90)) % 4
  when "F"
    case direction
    when 0
      coordinates[1] += value
    when 1
      coordinates[0] += value
    when 2
      coordinates[1] -= value
    when 3
      coordinates[0] -= value
    end
  end
end

puts coordinates.map { |n| n.abs }.reduce(:+)
