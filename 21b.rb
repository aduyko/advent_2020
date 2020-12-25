# Find the ingredients that are allergens sorted alphabetically by allergen, comma separated, same allergen rules as part 1
input_file = "inputs/21.txt"
input = []

File.open(input_file) do |f|
  input = f.read.split("\n").map { |x| x.delete(")").split("(contains ") }
  input.map { |x| x[0] = x[0].split(" "); x[1] = x[1].split(", ") }
end

allergies = {}
input.each do |row|
  row[1].each do |allergy|
    allergies[allergy] = row[0].clone unless allergies.include? allergy
    allergies[allergy] = allergies[allergy] & row[0]
  end
end

found_allergens = {}
done = false
until done
  done = true
  allergies.each do |allergy, allergens|
    if allergens.length > 1
      found_allergens.keys.each { |a| allergies[allergy].delete(a) }
    end
    if allergens.length == 1
      found_allergens[allergens[0]] = allergy
    else
      done = false
    end
  end
end

print found_allergens.sort_by { |k,v| v }.map { |a| a[0] }.join(",")
