# Apply bitmask to all entries

input_file = "inputs/14.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map{ |n| n.split(" = ") }
end

mask = ""
mem = {}
input.each do |instruction|
  if instruction[0] == "mask"
    mask = instruction[1]
    next
  end
  mem_address = instruction[0].scan(/\d+/)
  # Padded binary of length of mask
  bits = "%0#{mask.length}b" % instruction[1]
  mask.chars.each_with_index do |mask_char, idx|
    if mask_char != 'X'
      bits[idx] = mask_char
    end
  end
  mem[mem_address] = bits.to_i(2)
end

print mem.values.reduce(:+)
