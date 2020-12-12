# with 128 rows and 8 columns and using "first half, last half" notation, figure out which seat a string refers to. F and B are first and last half for rows, L and R are for columns. Return the row * 8 plus the column

input_file = "inputs/5.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

highest_id = 0
x = input[0]
input.each do |x|
  rows = [0,127]
  cols = [0,7]
  x.each_char do |c|
    if c == "F"
      rows[1] = ((rows[0]+rows[1])/2).floor()
    end
    if c == "B"
      rows[0] = ((rows[0]+rows[1])/2).floor()
    end
    if c == "L"
      cols[1] = ((cols[0]+cols[1])/2).floor()
    end
    if c == "R"
      cols[0] = ((cols[0]+cols[1])/2).floor()
    end
  end
  row = rows[1]
  col = cols[1]

  seat_id = (row * 8) + col
  highest_id = seat_id if seat_id > highest_id
end

puts highest_id
