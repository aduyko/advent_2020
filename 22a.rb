# Compare two cards, high card takes both and moves to bottom of deck, high card first, keep going until one player has all cards
# Score is 1 * bottom + 2 * second from bottom + 3 * third from bottom etc
input_file = "inputs/22.txt"
input = []

File.open(input_file) do |f|
  input = f.read.gsub(/Player.*\n/,"").split("\n\n").map { |x| x.split("\n").map { |i| i.to_i } }
end

until input[0].length == 0 or input[1].length == 0
  card_1 = input[0].shift
  card_2 = input[1].shift
  if card_1 > card_2
    input[0] << card_1
    input[0] << card_2
  else # Assuming one is always greater than the other and they're never equal
    input[1] << card_2
    input[1] << card_1
  end
end

winner = input[1] if input[0].length == 0
winner = input[0] if input[1].length == 0

print winner.reverse.map.with_index { |card, index| card * (index + 1) }.reduce(:+)
