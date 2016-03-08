def detect_single_byte_xor(file)
  File.readlines(file).map do |line|
    hex_decode_xor_ascii_full(line.chomp)
  end.max_by do |a|
    a[2]
  end[0]
end
