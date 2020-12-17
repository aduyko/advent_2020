# find which ticket values are invalid for ANY rules and return their sum

input_file = "inputs/16.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n\n")
  input[0] = input[0].scan(/\d+-\d+/)
  input[0] = input[0].map { |x| x.split("-").map(&:to_i) }
  input[1] = (input[1].split("\n")[1]).split(",")
  input[2] = (input[2].split("\n")[1..-1]).map { |x| x.split(",").map(&:to_i) }
end

#We could merge all overlapping ranges in input[0] but the input is short enough that it doesn't matter and we can do this naively

invalid_sum = 0
input[2].each do |ticket|
  ticket.each do |ticket_num|
    in_range = false
    input[0].each do |range|
      if ticket_num.between?(range[0],range[1])
        in_range = true
      end
    end
    unless in_range
      invalid_sum += ticket_num
    end
  end
end

print invalid_sum
