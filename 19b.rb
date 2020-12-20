# Check if strings match rule 0, where rule 8 = [42 | 42 8] and rule 11 = [42 31 | 42 11 31]
# Just hard coded the rule special cases

input_file = "inputs/19.txt"
input = []
rules = {}
test_cases = []

File.open(input_file) do |f|
  input = f.read.split("\n\n")
  test_cases = input[1].split("\n")
  rules = Hash[input[0].delete("\"").split("\n").map { |x| x.split(": ") }]
  rules.each do |k,v|
    rules_or = v.split("|").map { |x| x.strip.split }
    rules[k] = rules_or
  end
end

def build_regex(regex_string, key, rules)
  regex_string += "(?:"
  rules[key].each_with_index do |rule_or,idx|
    if key == "11"
      # Rule 11 has two rules
      first_rule_regex = build_regex("", rule_or[0], rules)
      second_rule_regex = build_regex("", rule_or[1], rules)
      # Recursive regex for rule 11 - basically balance any number of rule 1 with an equal number of rule 2
      regex_string += "(" + first_rule_regex + '\g<1>?' + second_rule_regex + ")"
    else
      regex_string += "(?:"
      rule_or.each do |rule|
        if rules.include? rule
          rule_string = build_regex("", rule, rules)
        else
          rule_string = rule
        end
        regex_string += rule_string
      end
      regex_string += ")"
      if idx < rules[key].length - 1
        regex_string += "|"
      end
    end
  end
  regex_string += ")"
  regex_string += "+" if key == "8"
  return regex_string
end

rules["0"][0] << "$"
regex_string = build_regex("^","0",rules)

matches = 0
test_cases.each do |line|
  matches += 1 if line.match? regex_string
end
p matches
