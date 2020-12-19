# Do the math under the condition that + and * have an equal precedence in order of operations
# Puzzle input only uses single digit numbers

input_file = "inputs/18.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map { |x| x.delete(" ").chars }
end

sum_totals = 0
input.each do |problem|
  stack = [0,"+"]
  problem << ")"
  total = 0
  running_total = 0
  operator = "+"

  problem.each_with_index do |symbol|
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
