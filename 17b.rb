# Expand in 4 dimensions each time, checking and swapping between . and # based on number of neighbors in all dimensions
# Brute force solution, runs fast enough

input_file = "inputs/17_test.txt"
input = []
iterations = 6
File.open(input_file) do |f|
  input_hypercube = []
  input_matrix = f.read.split("\n").map { |x| x.split("") }
  input_matrix.each do |input_row|
    iterations.times do; input_row.unshift("."); end
    iterations.times do; input_row << "."; end
  end
  row_length = input_matrix[0].length
  iterations.times do; input_matrix.unshift(Array.new(row_length,".")); end
  iterations.times do; input_matrix << Array.new(row_length,"."); end

  iterations.times do; input_hypercube << Array.new(row_length) { Array.new(row_length,".") }; end
  input_hypercube << input_matrix
  iterations.times do; input_hypercube << Array.new(row_length) { Array.new(row_length,".") }; end

  cube_length = input_hypercube.length

  iterations.times do; input << Array.new(cube_length) { Array.new(row_length) { Array.new(row_length, ".") } }; end
  input << input_hypercube
  iterations.times do; input << Array.new(cube_length) { Array.new(row_length) { Array.new(row_length, ".") } }; end
end

directions_to_check = [-1,0,1].repeated_permutation(4).to_a.reject { |x| x==[0,0,0,0] }

active_cells = 0
iterations.times do |i|
  active_cells = 0
  input_clone = Marshal.load(Marshal.dump(input))
  input.each_with_index do |cube, cube_idx|
    cube.each_with_index do |layer, layer_idx|
      layer.each_with_index do |row, row_idx|
        row.each_with_index do |col, col_idx|
          surrounding = 0
          directions_to_check.each do |direction|
            check_coordinates = [
              cube_idx + direction[0],
              layer_idx + direction[1],
              row_idx + direction[2],
              col_idx + direction[3]
            ]
            if (check_coordinates[0]).between?(0,input.length-1) &&
               (check_coordinates[1]).between?(0,cube.length-1) &&
               (check_coordinates[2]).between?(0,layer.length-1) &&
               (check_coordinates[3]).between?(0,row.length-1)
              if input[check_coordinates[0]][check_coordinates[1]][check_coordinates[2]][check_coordinates[3]] == "#"
                surrounding += 1
              end
            end
          end
          if col == "#" and not surrounding.between?(2,3)
            input_clone[cube_idx][layer_idx][row_idx][col_idx] = "."
          elsif col == "." and surrounding == 3
            input_clone[cube_idx][layer_idx][row_idx][col_idx] = "#"
          end
          if input_clone[cube_idx][layer_idx][row_idx][col_idx] == "#"
            active_cells += 1
          end
        end
      end
    end
  end
  input = input_clone
end
puts active_cells
