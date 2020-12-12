# Count how many different bags a bag contains

input_file = "inputs/7.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

def count_bags(target, bags)
  #Count the bag we're looking inside
  contained_bags = bags[target]
  bags_count = 1
  contained_bags.each do |bag_name,num_bags|
    bags_count += (num_bags * count_bags(bag_name, bags))
  end
  return bags_count
end

# Hash of colors that contain how many bags they contain
# {:color => {:color => number}}

target = "shiny gold"
bags = {}
input.each do |sentence|
  s = sentence.split(" bags contain ", 2)
  current_bag = s[0]
  bags[current_bag] = {}
  contains = s[1].delete_suffix('.').split(', ')
  next if contains[0] == "no other bags"
  contains.each do |contain|
    contained = contain.sub(/ bag(s?)/,'').split(' ',2)
    contains_color = contained[1]
    contains_count = contained[0].to_i
    bags[current_bag][contains_color] = contains_count
  end
end

# Subtract one because we want # of bags inside and therefore don't count our initial golden bag
print count_bags(target, bags) - 1
