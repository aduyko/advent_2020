# Fill the seats (L/#) according to how many # are in the surrounding seats

input_file = "inputs/11.txt"
input = []
input_row_length = 0
File.open(input_file) do |f|
  input = f.read.split("\n")
  input_row_length = input[0].length
  input = input.join
end

directions = [
  -input_row_length - 1,
  -1,
  input_row_length - 1,
  -input_row_length,
  input_row_length,
  -input_row_length + 1,
  1,
  input_row_length + 1
]

previous_input = ""
until previous_input == input
  previous_input = input.clone
  previous_input.chars.each_with_index do |seat,seat_idx|
    num_adjacent = 0
    allowed_directions = directions.clone
    if seat_idx % input_row_length == 0
      allowed_directions = allowed_directions[3,5]
    elsif seat_idx % input_row_length == input_row_length - 1
      allowed_directions = allowed_directions[0,5]
    end
    allowed_directions.each do |offset|
      check_idx = seat_idx + offset
      if check_idx >= 0 and check_idx < previous_input.length
        if previous_input[check_idx] == "#"
          num_adjacent += 1
        end
      end
    end
    if input[seat_idx] != "."
      if num_adjacent == 0
        input[seat_idx] = "#"
      end
      if num_adjacent >= 4
        input[seat_idx] = "L"
      end
    end
  end
end

print input.count("#")
