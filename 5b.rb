# with 128 rows and 8 columns and using "first half, last half" notation, figure out which seat a string refers to. F and B are first and last half for rows, L and R are for columns. Return the row * 8 + column of the missing seat, assuming there is nothing before the first and nothing after the last seat.

input_file = "inputs/5.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n")
end

seats = []
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
  seats.push(seat_id)
end

seats.sort!
seats.each_with_index do |seat,idx|
  break if idx == seats.length - 1
  puts seat+1 if seats[idx+1] != seat+1
end
