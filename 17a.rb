# Expand in 3 dimensions each time, checking and swapping between . and # based on number of neighbors in all dimensions
# Brute force solution, runs fast enough

input_file = "inputs/17.txt"
input = []
iterations = 6
File.open(input_file) do |f|
  input_matrix = f.read.split("\n").map { |x| x.split("") }
  input_matrix.each do |input_row|
    iterations.times do; input_row.unshift("."); end
    iterations.times do; input_row << "."; end
  end
  row_length = input_matrix[0].length
  iterations.times do; input_matrix.unshift(Array.new(row_length,".")); end
  iterations.times do; input_matrix << Array.new(row_length,"."); end
  iterations.times do; input << Array.new(row_length) { Array.new(row_length,".") }; end
  input << input_matrix
  iterations.times do; input << Array.new(row_length) { Array.new(row_length,".") }; end
end

directions_to_check = []
number_directions = [-1,0,1]
number_directions.each do |i|
  number_directions.each do |j|
    number_directions.each do |z|
      unless i == 0 && j == 0 && z == 0
        directions_to_check << [i,j,z]
      end
    end
  end
end

active_cells = 0
iterations.times do |i|
  active_cells = 0
  input_clone = Marshal.load(Marshal.dump(input))
  input.each_with_index do |layer, layer_idx|
    layer.each_with_index do |row, row_idx|
      layer_clone = layer.clone
      row.each_with_index do |col, col_idx|
        surrounding = 0
        directions_to_check.each do |direction|
          check_coordinates = [
            layer_idx + direction[0],
            row_idx + direction[1],
            col_idx + direction[2]
          ]
          if (check_coordinates[0]).between?(0,input.length-1) &&
             (check_coordinates[1]).between?(0,layer.length-1) &&
             (check_coordinates[2]).between?(0,row.length-1)
            if input[check_coordinates[0]][check_coordinates[1]][check_coordinates[2]] == "#"
              surrounding += 1
            end
          end
        end
        if col == "#" and not surrounding.between?(2,3)
          input_clone[layer_idx][row_idx][col_idx] = "."
        elsif col == "." and surrounding == 3
          input_clone[layer_idx][row_idx][col_idx] = "#"
        end
        if input_clone[layer_idx][row_idx][col_idx] == "#"
          active_cells += 1
        end
      end
    end
  end
  input = input_clone
end
puts active_cells
