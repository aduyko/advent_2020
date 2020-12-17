# Return the product of the six fields corresponding to the first 6 rules from my_ticket
require 'set'

input_file = "inputs/16.txt"
input = []
all_ranges = []
rules = []
my_ticket = []
tickets = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
  all_ranges = input[0].scan(/\d+-\d+/)
  all_ranges = all_ranges.map { |x| x.split("-").map(&:to_i) }
  # Array of rules, where each rule is two [min,max] arrays
  rules = input[0].split("\n").map { |x| x.scan(/\d+-\d+/) }.map { |row| row.map { |x| x.split("-").map(&:to_i) } }
  my_ticket = (input[1].split("\n")[1]).split(",").map(&:to_i)
  tickets = (input[2].split("\n")[1..-1]).map { |x| x.split(",").map(&:to_i) }
end

invalid_tickets = []
tickets.each_with_index do |ticket,idx|
  ticket.each do |ticket_num|
    valid = false
    all_ranges.each do |range|
      if ticket_num.between?(range[0],range[1])
        valid = true
      end
    end
    unless valid
      invalid_tickets << idx
    end
  end
end

valid_tickets = tickets.reject.with_index { |v,i| invalid_tickets.include? i }
valid_tickets << my_ticket

# valid_candidates are sets of ticket indexes that are valid for the given index, corresponding to a rule index
valid_candidates = Array.new(rules.length)
valid_candidates.each_with_index do |candidate, idx|
  valid_candidates[idx] = (0...my_ticket.length).to_set
end

# Remove invalid ticket indexes from rules, so we are left with an array of sets of valid ticket indexes for each rule index
valid_tickets.each do |ticket|
  ticket.each_with_index do |ticket_num, ticket_idx|
    rules.each_with_index do |rule_ranges, rule_idx|
      rule_applies = false
      rule_ranges.each do |range|
        if ticket_num.between?(range[0],range[1])
          rule_applies = true
        end
      end
      unless rule_applies
        valid_candidates[rule_idx].delete ticket_idx
      end
    end
  end
end

#clunky loop to reduce our rule_idx:ticket_idx mappings to 1:1 - starting with our smallest set of valid ticket indexes for a rule index (which is size 1), remove that ticket index from all other sets of ticket indexes until every rule only has one corresponding ticket field
sorted_candidates = valid_candidates.sort_by(&:length)
sorted_candidates.each_with_index do |found_idx, idx|
  break if idx == sorted_candidates.length - 1
  valid_candidates.each do |unsorted_candidate|
    if unsorted_candidate.length > 1
      unsorted_candidate.subtract(found_idx)
    end
  end
  sorted_candidates[idx+1..-1].map { |bigger_set| bigger_set.subtract(found_idx) }
end

# Return the product of the six fields corresponding to the first 6 rules from my_ticket
print valid_candidates[0,6].map { |x| x.to_a }.flatten.map { |i| my_ticket[i] }.reduce(:*)
