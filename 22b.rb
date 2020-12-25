# Compare two cards, high card takes both and moves to bottom of deck, high card first, keep going until one player has all cards
# Score is 1 * bottom + 2 * second from bottom + 3 * third from bottom etc
# Recurse if same two cards have been played before
# win for player 1 if cards have been played with same cards remaining in deck
# My original solution was correct but did not use sets or hashes for configuration and took forever to run, using hash and set inspired by reddit user "whereflamingosfly"
# https://pastebin.com/HVSAYhnT

require 'set'

input_file = "inputs/22.txt"
input = []

File.open(input_file) do |f|
  input = f.read.gsub(/Player.*\n/,"").split("\n\n").map { |x| x.split("\n").map { |i| i.to_i } }
end

def play_game(deck_1, deck_2)
  played_configurations = Set.new()

  until deck_1.length == 0 or deck_2.length == 0
    configuration = [deck_1,deck_2].hash
    if played_configurations.include?(configuration)
      return [1,deck_1]
    end
    played_configurations << configuration

    winner = 1
    card_1 = deck_1.shift
    card_2 = deck_2.shift
    
    if card_1 <= deck_1.length && card_2 <= deck_2.length
      winner = play_game(deck_1.take(card_1),deck_2.take(card_2))[0]
    elsif card_1 > card_2
      winner = 1
    else # Assuming one is always greater than the other and they're never equal
      winner = 2
    end

    if winner == 1
      deck_1 << card_1
      deck_1 << card_2
    else
      deck_2 << card_2
      deck_2 << card_1
    end
  end

  if deck_1.length == 0
    return [2,deck_2]
  else
    return [1,deck_1]
  end
end


print play_game(input[0],input[1])[1].reverse.map.with_index { |card, index| card * (index + 1) }.reduce(:+)
