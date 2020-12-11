# Fill the seats (L/#) according to number of # seats visible in 8 cardinal directions

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
      checked = false
      check_idx = seat_idx + offset
      until checked
        # Check what square we're looking at if we're within the top/bottom bounds of the input
        if check_idx >= 0 and check_idx < previous_input.length
          if previous_input[check_idx] == "#"
            num_adjacent += 1
            checked = true
          elsif previous_input[check_idx] == "L"
            checked = true
          end
        else
          checked = true
        end
        # Short circuit if we are at the left or right edge
        if check_idx % input_row_length == 0
          if [-input_row_length - 1,-1,input_row_length - 1].include? offset
            checked = true 
          end
        end
        if check_idx % input_row_length == input_row_length - 1
          if [-input_row_length + 1,1,input_row_length + 1].include? offset
            checked = true 
          end
        end
        # Not at an edge and we haven't seen anything yet, continue
        check_idx = check_idx + offset
      end
    end
    if input[seat_idx] != "."
      if num_adjacent == 0
        input[seat_idx] = "#"
      end
      if num_adjacent >= 5
        input[seat_idx] = "L"
      end
    end
  end
end

print input.count("#")
