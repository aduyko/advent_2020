# Do the math under the condition that + has precedence over * in order of operations
# Puzzle input only uses single digit numbers

input_file = "inputs/18.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map { |x| x.delete(" ").chars }
end

sum_totals = 0

input.each do |problem|
  # Parse the problem, basically splitting on "*", using * and () to figure out where to place parentheses
  # Terminators essentially represents unclosed ( parentheses and how they were added
  parsed_problem = []
  terminators = []

  problem.each do |symbol|
    case symbol
    when "*"
      if terminators[-1] == "*"
        parsed_problem << ")"
      else
        terminators << "*"
      end
      parsed_problem << "*"
      parsed_problem << "("
    when "("
      terminators << "("
      parsed_problem << "("
    when ")"
      # On ), we close all (, including those we added with *, up to and including the ( that would have been closed by this ) in the original problem
      begin
        parsed_problem << ")"
        last_terminator = terminators.pop
      end until last_terminator == "("
    else
      parsed_problem << symbol
    end
  end
  until terminators.empty? do
    parsed_problem << ")"
    terminators.pop
  end

  # Part 1 solution still works to process our modified problem
  stack = [0,"+"]
  parsed_problem << ")"
  total = 0
  running_total = 0
  operator = "+"

  parsed_problem.each do |symbol|
    case symbol
    when "("
      stack << running_total
      stack << operator
      running_total = 0
      operator = "+"
    when ")"
      operator = stack.pop
      total = stack.pop
      case operator
      when "+"
        total = running_total + total
      when "*"
        total = running_total * total
      end
      running_total = total
    when "+","*"
      operator = symbol
    else
      case operator
      when "+"
        running_total = running_total + symbol.to_i
      when "*"
        running_total = running_total * symbol.to_i
      end
    end
  end
  sum_totals += total
end

print sum_totals
