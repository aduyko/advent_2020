# Apply bitmask to all addresses, then save value to all possibilities for those addresses where X is a wildcard

input_file = "inputs/14.txt"
input = []
File.open(input_file) do |f|
  input = f.read.split("\n").map{ |n| n.split(" = ") }
end

# Dynamic programming: Append bits until you run out of mask and branch at X
def build_addresses(address, mask)
  addresses = []
  mask.chars.each_with_index do |bit,idx|
    if bit == "X"
      addresses.concat build_addresses(address + "0", mask[idx+1..-1])
      addresses.concat build_addresses(address + "1", mask[idx+1..-1])
      return addresses
    else
      address = address + bit
    end
  end
  addresses << address
  return addresses
end

mask = ""
mem = {}
input.each do |instruction|
  if instruction[0] == "mask"
    mask = instruction[1]
    next
  end
  mem_address = instruction[0].scan(/\d+/)
  mem_value = instruction[1].to_i
  # Padded binary of length of mask
  bits = "%0#{mask.length}b" % mem_address
  mask.chars.each_with_index do |mask_char, idx|
    if mask_char == "1"
      bits[idx] = "1"
    elsif mask_char == "X"
      bits[idx] = "X"
    end
  end
  if bits.include? "X"
    addresses = build_addresses("",bits)
    addresses.each do |bit_address|
      address = bit_address.to_i(2)
      mem[address] = mem_value
    end
  else
    mem[mem_address] = mem_value
  end
end

print mem.values.reduce(:+)
