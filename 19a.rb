# Check if strings match rule 0

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

def build_regex(regex_string, target_string, key, rules)
  regex_string += "("
  rules[key].each_with_index do |rule_or,idx|
    regex_string += "("
    rule_or.each do |rule|
      if rules.include? rule
        regex_string = build_regex(regex_string, target_string, rule, rules)
      else
        regex_string += rule
      end
    end
    regex_string += ")"
    if idx < rules[key].length - 1
      regex_string += "|"
    end
  end
  regex_string += ")"
  return regex_string
end

rules["0"][0] << "$"
regex_string = build_regex("^","","0",rules)

matches = 0
test_cases.each do |line|
  matches += 1 if line.match? regex_string
end
p matches
