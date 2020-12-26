# Do a bunch of rules to move 3 cups at a time
# Performance wasn't working with array slices so I looked up solutions and found the hint to use linked lists for this for improved performance
input_file = "inputs/23.txt"
input = []

File.open(input_file) do |f|
  input = f.read.chomp.split("").map { |i| i.to_i }
end

# Our linked list! To be honest after some thought, we could probably skip this entirely and just have an array where indexes are labels and values are the "next", which works because we are sequentially filling in every number from 1 to 1_000_000
Cup = Struct.new(:label, :next)

cups = Array.new(input.length + 1) # Adding one because there is no 0 label
current_cup = nil

input.each do |input_cup|
  next_cup = Cup.new(input_cup,nil)
  cups[next_cup.label] = next_cup
  current_cup.next = next_cup unless current_cup.nil? #unless is just for the first cup we create
  current_cup = next_cup
end

# Fill in up to 1_000_000 - use 1_000_001 because we have an unused 0 index
max_cup = input.max
next_cup_label = max_cup + 1
(1_000_001 - cups.length).times do |n|
  next_cup = Cup.new(next_cup_label + n, nil)
  cups <<  next_cup
  current_cup.next = next_cup
  current_cup = next_cup
end

# Close the loop
current_cup.next = cups[input[0]]

current_cup = cups[input[0]]
rounds = 10_000_000
rounds.times do |round|
  selected_cup = current_cup.next
  next_cup = selected_cup.next.next.next
  selected_labels = [selected_cup.label, selected_cup.next.label, selected_cup.next.next.label]
  destination_label = current_cup.label - 1
  while selected_labels.include? destination_label or destination_label < 1
    destination_label -= 1
    if destination_label < 1
      destination_label = cups.length - 1
    end
  end
  destination_cup = cups[destination_label]
  selected_cup.next.next.next = destination_cup.next
  destination_cup.next = selected_cup
  current_cup.next = next_cup
  current_cup = current_cup.next
end

star_1_label = cups[1].next.label
star_2_label = cups[1].next.next.label

print star_1_label * star_2_label
