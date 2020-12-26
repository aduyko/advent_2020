# Do a bunch of rules to move 3 cups at a time
# Performance wasn't working with array slices so I looked up solutions and found the hint to use linked lists for this for improved performance
# This does not use linked lists the way 23b does and just uses array indexes to represent cup labels and array values to represent the next cup's label
# This runs ~ 3 times faster than the linked list version

input_file = "inputs/23.txt"
input = []

File.open(input_file) do |f|
  input = f.read.chomp.split("").map { |i| i.to_i }
end

cups = Array.new(input.length + 1) # Adding one because there is no 0 label
current_cup = nil

input.each do |input_cup|
  next_cup = input_cup
  cups[current_cup] = next_cup unless current_cup.nil? # unless is just for the first cup we create
  current_cup = next_cup
end

# Fill in up to 1_000_000 - use 1_000_001 because we have an unused 0 index
max_cup = input.max
next_cup_label = max_cup + 1
cups[current_cup] = next_cup_label
(1_000_001 - cups.length).times do |n|
  next_cup = next_cup_label + n + 1
  cups << next_cup
end

# Close the loop
cups[-1] = input[0]

current_cup = input[0]
rounds = 10_000_000
# cups[*] is equivalent to cup_with_label_*.next
rounds.times do |round|
  selected_cup = cups[current_cup]
  next_cup = cups[cups[cups[selected_cup]]]
  selected_labels = [selected_cup, cups[selected_cup], cups[cups[selected_cup]]]
  destination_label = current_cup - 1
  while selected_labels.include? destination_label or destination_label < 1
    destination_label -= 1
    if destination_label < 1
      destination_label = cups.length - 1
    end
  end
  cups[cups[cups[selected_cup]]]= cups[destination_label]
  cups[destination_label] = selected_cup
  cups[current_cup] = next_cup
  current_cup = cups[current_cup]
end

star_1_label = cups[1]
star_2_label = cups[cups[1]]

print star_1_label * star_2_label
