# Follow line of hexagonal directions to find which tile to flip, flip or unflip it, count all flipped tiles
input_file = "inputs/24.txt"
input = ""

File.open(input_file) do |f|
  input = f.read.split("\n")
end

tiles = {"0_0" => 0} # 0 for unflipped, 1 for flipped

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
    tiles[next_tile] = (tiles[next_tile] + 1) % 2
  else
    tiles[next_tile] = 1
  end
end

print tiles.values.reduce(:+)
