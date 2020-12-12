# Count how many differnet bags can contain your target bag at some nesting level

input_file = "inputs/7.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

#Starting at target, recursively merge all the names of bags that contain "target" bag into a hash and return it
def get_container_bag_names(target, bags)
  containing_bags = bags[target].clone
  bags[target].each do |bag_name,v|
    containing_bags.merge! get_container_bag_names(bag_name, bags)
  end
  return containing_bags
end

# Hash of colors that contain and how many of this bag they contain
# {:color => {:color => number}}
# Kind of an upside-down tree. Every bag knows who contains it, instead of the way the original data is formatted

target = "shiny gold"
bags = {}
ways_to_get_to_target = 0
input.each do |sentence|
  s = sentence.split(" bags contain ", 2)
  current_bag = s[0]
  bags[current_bag] = {} unless bags.key? current_bag
  contains = s[1].delete_suffix('.').split(', ')
  next if contains[0] == "no other bags"
  contains.each do |contain|
    contained = contain.sub(/ bag(s?)/,'').split(' ',2)
    contains_color = contained[1]
    contains_count = contained[0].to_i
    if bags.key?(contains_color)
      bags[contains_color][current_bag] = contains_count
    else
      bags[contains_color] = {}
      bags[contains_color][current_bag] = contains_count
    end
  end
end

print get_container_bag_names(target, bags).length
