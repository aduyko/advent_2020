# Do a bunch of rules to move 3 cups at a time
input_file = "inputs/23.txt"
cups = []

File.open(input_file) do |f|
  cups = f.read.chomp.split("").map { |i| i.to_i }
end

rounds = 100
current_cup = cups[0]
current_cup_index = 0
rounds.times do |round|
  selection = []
  remaining_cups = cups.length - (current_cup_index + 1)
  if current_cup_index + 1 == cups.length
    selection = cups.slice!(0,3)
  elsif remaining_cups >= 3
    selection = cups.slice!(current_cup_index + 1,3)
  else
    selection = cups.slice!(current_cup_index + 1,remaining_cups)
    selection += cups.slice!(0,3 - remaining_cups)
  end
  destination_cup = current_cup - 1
  until cups.include? destination_cup or destination_cup < cups.min
    destination_cup -= 1
  end
  if destination_cup < cups.min
    destination_cup = cups.max
  end
  destination_index = cups.index(destination_cup) + 1
  cups.insert(destination_index,selection).flatten!

  current_cup_index = cups.index(current_cup) + 1
  current_cup_index = 0 if current_cup_index == cups.length
  current_cup = cups[current_cup_index]
end

print cups.map { |x| x.to_s }.join.split("1").reverse.join
