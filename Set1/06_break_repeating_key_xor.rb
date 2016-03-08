require_relative "./03_single_byte_xor_cipher"

NUM_SIZES = 2

def normalized_hamming_distance(s1, s2)
  raise "must compare strings of equal length" if s1.length != s2.length
  d = 0
  s1.chars.zip(s2.chars).each do |a|
    d += (a[0].ord ^ a[1].ord).to_s(2).count('1')
  end
  
  d.fdiv(s1.length)
end

# returns an array of 4 likely keysizes
def keysizes(code)
  (2..40).to_a.map do |s|
    chunks = code.scan(/.{#{s}}/)
    chunks.pop if chunks.length % 2 != 0
    if chunks.empty?
      [s, 9]
    else
      [
        s, 
        chunks.each_slice(2).to_a.inject(0) do |dis, a|
          dis + normalized_hamming_distance(a[0], a[1])
        end * (2.fdiv(chunks.length))
      ]
    end
  end.sort_by do |el| 
    el[1]
  end[0...NUM_SIZES].map do |el|
    el[0]
  end
end

def keysize(code)
  (2..20).to_a.map do |s|
    chunks = code.scan(/.{#{s}}/)
    chunks.pop if chunks.length % 2 != 0
    if chunks.length < 4
      [s, 9]
    else
      [
        s, 
        chunks.each_slice(2).to_a.inject(0) do |dis, a|
          dis + normalized_hamming_distance(a[0], a[1])
        end * (2.fdiv(chunks.length))
      ]
    end
  end.sort_by do |el| 
    el[1]
  end[0][0]
end

def strings_transpose(arr)
  a = arr.map do |str|
    str.chars
  end
  a[0].zip(*a[1..-1]).map do |chars|
    chars.join
  end
end

def get_keys(code)
  keysizes(code).map do |size|
    chunks = strings_transpose(code.scan(/.{1,#{size}}/))
    chunks.map! do |chunk|
      decode_single_byte_xor(binary_to_hex(chunk))[1]
    end
    chunks.map { |a| a.chr }.join
  end
end

# so slow
def get_combos(arr)
  return arr.first.map{ |a| [a] } if arr.length == 1

  combos = []
  get_combos(arr[1..-1]).each do |a|
    arr[0].each do |el|
      combos << [el] + a
    end
  end

  combos
end

def rkx_combos(code)
  keysizes(code).map do |size|
    chunks = strings_transpose(code.scan(/.{1,#{size}}/))
    chunks.map! do |chunk|
      get_single_decodings(binary_to_hex(chunk))
    end

    get_combos(chunks).map do |combo|
      message = string_transpose(combo).join
      [message, score_english_combos(message)]
    end.sort_by { |el| el[1] }.last
  end.sort_by { |el| el[1] }.last[0]
end

def repeating_key_xor_decode(code)
  # size, message, score
  keysizes(code).map do |size|
    chunks = strings_transpose(code.scan(/.{1,#{size}}/))
    chunks.map! do |chunk|
      decode_single_byte_xor(binary_to_hex(chunk))[0]
    end
    message = strings_transpose(chunks).join
    [size, message, score_english(message)]
  end.sort_by { |el| el[2] }.last
end

def rkx_decode(code)
  # size, message, score
  size = keysize(code)
  chunks = strings_transpose(code.scan(/.{1,#{size}}/))
  chunks.map! do |chunk|
    decode_single_byte_xor(binary_to_hex(chunk))
  end
  key = chunks.map { |c| c[1].chr }.join
  chunks = chunks.map { |c| c[0] }
  message = strings_transpose(chunks).join
  [message, size, key, score_english(message)]
end

def base64_repeating_key_xor_decode(file)
  repeating_key_xor_decode(
    Base64.strict_decode64(
      File.readlines(file).map { |line| line.chomp }.join
    )
  )
end

def base64_rkx_decode(file)
  rkx_decode(
    Base64.strict_decode64(
      File.readlines(file).map { |line| line.chomp }.join
    )
  )
end
