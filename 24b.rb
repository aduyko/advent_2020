# Follow line of hexagonal directions to find which tile to flip, flip or unflip it
# Then every "day" flip all unflipped tiles with 2 adjacent flipped, or flipped with 0 or more than 2 adjacent unflipped
input_file = "inputs/24.txt"
input = ""

File.open(input_file) do |f|
  input = f.read.split("\n")
end

tiles = {"0_0" => [0,0,0]} # 0 for unflipped, 1 for flipped, x, y for convenience

input.each do |tile_instructions|
  x = 0
  y = 0
  direction = ""
  next_tile = "0_0"
  tile_instructions.chars.each do |char|
    if char == "n" or char == "s"
      direction = char
      next
    end
    direction += char
    case direction
    when "e"
      x += 2
    when "w"
      x -= 2
    when "ne"
      x += 1
      y += 1
    when "nw"
      x -= 1
      y += 1
    when "se"
      x += 1
      y -= 1
    when "sw"
      x -= 1
      y -= 1
    end
    next_tile = "#{x}_#{y}"
    direction = ""
  end
  if tiles.key? next_tile
    tiles[next_tile][0] = (tiles[next_tile][0] + 1) % 2
  else
    tiles[next_tile] = [1,x,y]
  end
end

days = 100
days.times do |day|
  new_tiles = {}
  tiles_to_flip = []
  # For each tile, check if it should be flipped by looking at all of it's neighbors. If it is already flipped, make sure we are tracking any of it's unvisited neighbors in new_tiles in case they also need to be flipped
  tiles.each do |key,tile|
    adjacent_flipped = 0 
    tile_x = tile[1]
    tile_y = tile[2]

    checked_tile = "#{tile_x + 2}_#{tile_y}" 
    if tiles.key? checked_tile
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x + 2, tile_y]
    end
    checked_tile = "#{tile_x - 2}_#{tile_y}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x - 2, tile_y]
    end
    checked_tile = "#{tile_x + 1}_#{tile_y + 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x + 1, tile_y + 1]
    end
    checked_tile = "#{tile_x - 1}_#{tile_y + 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x - 1, tile_y + 1]
    end
    checked_tile = "#{tile_x + 1}_#{tile_y - 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x + 1, tile_y - 1]
    end
    checked_tile = "#{tile_x - 1}_#{tile_y - 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    elsif tile[0] == 1
      new_tiles[checked_tile] = [0, tile_x - 1, tile_y - 1]
    end

    if tile[0] == 0 and adjacent_flipped == 2
      tiles_to_flip << key
    elsif tile[0] == 1 and (adjacent_flipped == 0 or adjacent_flipped > 2)
      tiles_to_flip << key
    end
  end

  # Make sure we also flip any new tiles that we haven't visited that are adjacent to two flipped tiles
  new_tiles.each do |key,tile|
    adjacent_flipped = 0 
    tile_x = tile[1]
    tile_y = tile[2]

    checked_tile = "#{tile_x + 2}_#{tile_y}" 
    if tiles.key? checked_tile
      adjacent_flipped += tiles[checked_tile][0]
    end
    checked_tile = "#{tile_x - 2}_#{tile_y}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    end
    checked_tile = "#{tile_x + 1}_#{tile_y + 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    end
    checked_tile = "#{tile_x - 1}_#{tile_y + 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    end
    checked_tile = "#{tile_x + 1}_#{tile_y - 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    end
    checked_tile = "#{tile_x - 1}_#{tile_y - 1}" 
    if tiles.key? checked_tile 
      adjacent_flipped += tiles[checked_tile][0]
    end

    if adjacent_flipped == 2
      tiles_to_flip << key
    end
  end

  # Flip all of the tiles that need to be flipped
  tiles.merge!(new_tiles)
  tiles_to_flip.each do |key|
    tiles[key][0] = (tiles[key][0] + 1) % 2
  end
end

print tiles.values.map { |i| i[0] }.reduce(:+)
