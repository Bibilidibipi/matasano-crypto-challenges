require_relative "./02_fixed_xor"

ENGLISH_FREQUENCIES = {
  'a' => 8.167,
  'b' => 1.492,
  'c' => 2.782,
  'd' => 4.253,
  'e' => 12.702,
  'f' => 2.228,
  'g' => 2.015,
  'h' => 6.094,
  'i' => 6.966,
  'j' => 0.153,
  'k' => 0.772,
  'l' => 4.025,
  'm' => 2.406,
  'n' => 6.749,
  'o' => 7.507,
  'p' => 1.929,
  'q' => 0.095,
  'r' => 5.987,
  's' => 6.327,
  't' => 9.056,
  'u' => 2.758,
  'v' => 0.978,
  'w' => 2.361,
  'x' => 0.150,
  'y' => 1.974,
  'z' => 0.074,
  ' ' => 22
}

def score_english(str)
  str.split('').inject(0) do |a, c|
    score = ENGLISH_FREQUENCIES[c.downcase]
    score ? a + score : a - 20
  end.fdiv(str.length)
end

def hex_decode_xor_ascii(hex)
  hex_decode_xor_ascii_full(hex)[0]
end

# returns [message, key, score]
def hex_decode_xor_ascii_full(hex)
  (0..255).to_a.map do |i|
    a = i.chr
    ascii = hex_a_xor_ascii(hex, a)
    [ascii, a, score_english(ascii)]
  end.max_by{ |a| a[2] }
end

# def get_single_decodings(hex)
#   Hash[(1..255).to_a.map do |i|
#     [i, xor_score_english(hex, i)]
#   end].sort_by{ |k, v| v }.map{ |k, v| int_fixed_xor_binary(hex, k) }[-4..-1]
# end
