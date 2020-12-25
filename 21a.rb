# Find the ingredients that cannot possibly be allergens - only one ingredient corresponds to an allergen, allergens contained between all ingredients listed after ingredients
input_file = "inputs/21.txt"
input = []

File.open(input_file) do |f|
  input = f.read.split("\n").map { |x| x.delete(")").split("(contains ") }
  input.map { |x| x[0] = x[0].split(" "); x[1] = x[1].split(", ") }
end

allergies = {}
ingredients = {}
input.each do |row|
  row[0].each do |ingredient|
    ingredients[ingredient] ||= 0
    ingredients[ingredient] += 1
  end
  row[1].each do |allergy|
    allergies[allergy] = row[0].clone unless allergies.include? allergy
    allergies[allergy] = allergies[allergy] & row[0]
  end
end

allergies.each do |allergy, allergens|
  allergens.each { |a| ingredients.delete(a) }
end

print ingredients.values.reduce(:+)
