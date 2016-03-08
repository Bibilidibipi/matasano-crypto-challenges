require_relative "./01_convert_hex_to_base64"

def hex_a_xor_ascii(hex, a)
  hex_to_ascii(hex).bytes.map do |b|
    (b ^ a.ord).chr
  end.join
end

def a_xor_hex(a1, a2)
  (a1.ord ^ a2.ord).to_s(16).rjust(2, '0')
end

def hex_xor_hex(hex1, hex2)
  hex_to_ascii(hex1).chars.zip(hex_to_ascii(hex2).chars).map do |a|
    a_xor_hex(a[0], a[1])
  end.join
end
