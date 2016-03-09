require_relative "./01_convert_hex_to_base64"

def hex_a_xor_ascii(hex, a)
  hex_to_ascii(hex).bytes.map do |b|
    (b ^ a.ord).chr
  end.join
end

def a_xor_hex(a1, a2)
  (a1.ord ^ a2.ord).to_s(16).rjust(2, '0')
end

def ascii_xor(ascii1, ascii2)
  ascii1.chars.zip(ascii2.chars).map do |a|
    (a[0].ord ^ a[1].ord).chr
  end.join
end

def hex_xor(hex1, hex2)
  ascii_to_hex(ascii_xor(hex_to_ascii(hex1), hex_to_ascii(hex2)))
end
