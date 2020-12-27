# Rotate and arrange tiles to form a square, return product of corner tile id #s
# I started building out the entire map but realized the input is nice enough that corner tiles only have two edges with matches so we can end after finding all matched edges

input_file = "inputs/20.txt"
tiles = {}

# tiles = { :id => [[side_value,{ :partner_id => :side }]] }

File.open(input_file) do |f|
  input = f.read.split("\n\n").map { |x| x.split("\n") }
  input.each do |i|
    tile_id = i[0].scan(/\d+/)[0]
    tile = i[1..-1].map { |t| t.split "" }
    tiles[tile_id] = []
    4.times do |rotation|
      tiles[tile_id] << []
      tiles[tile_id][rotation] << tile[0].join
      tiles[tile_id][rotation] << {}
      tile = tile.transpose.map { |t| t.reverse }
    end
  end
end

# Find all possible pairs for all sides and orientations of our tiles
tiles_to_check = tiles.keys
tiles.keys.each do |tile|
  tiles_to_check.shift
  max_matches = 0
  tiles_to_check.each do |pair_tile|
    4.times do |rotation|
      4.times do |pair_rotation|
        if tiles[tile][rotation][0].reverse == tiles[pair_tile][pair_rotation][0].reverse ||
           tiles[tile][rotation][0].reverse == tiles[pair_tile][pair_rotation][0] ||
           tiles[tile][rotation][0] == tiles[pair_tile][pair_rotation][0].reverse ||
           tiles[tile][rotation][0] == tiles[pair_tile][pair_rotation][0]
          max_matches += 1

          tiles[tile][rotation][1][pair_tile] = true
          tiles[pair_tile][pair_rotation][1][tile] = true
        end
      end
    end
  end
end

product = 1
tiles.each do |tile_id,v|
  matched_sides = 0
  v.each do |side|
    matched_sides += 1 if side[1].length > 0
  end
  product *= tile_id.to_i if matched_sides == 2
end

puts product
