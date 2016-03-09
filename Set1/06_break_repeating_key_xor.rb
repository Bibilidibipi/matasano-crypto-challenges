require_relative "./03_single_byte_xor_cipher"

def normalized_hamming_distance(s1, s2)
  raise "must compare strings of equal length" if s1.length != s2.length
  d = 0
  s1.chars.zip(s2.chars).each do |a|
    d += (a[0].ord ^ a[1].ord).to_s(2).count('1')
  end
  
  d.fdiv(s1.length)
end

def get_chunks(str, length, partials)
  chunks = []
  i = 0
  until i >= str.length
    chunks << str[i...(i + length)] unless !partials && i > str.length - length
    i += length
  end

  chunks
end

# takes ascii
def keysize(code)
  size = 0
  dis = 9

  # [size, average normalized hamming distance]
  (2..40).each do |s|
    chunks = get_chunks(code, s, false)
    chunks.pop if chunks.length % 2 != 0
    break if chunks.empty?
    d = chunks.each_slice(2).to_a.inject(0) do |total_d, a|
      total_d + normalized_hamming_distance(a[0], a[1])
    end * (2.fdiv(chunks.length))

    if d < dis - 1 || 
     (d < dis && s % size != 0) || 
     (d < dis && size == 2)
      dis = d
      size = s
    end
  end

  size
end

def strings_transpose(arr)
  a = arr.map do |str|
    str.chars
  end
  a[0].zip(*a[1..-1]).map do |chars|
    chars.join
  end
end

# takes ascii
def rkx_decode(code)
  chunks = strings_transpose(get_chunks(code, keysize(code), true))
  chunks.map! do |chunk|
    hex_decode_xor_ascii_full(ascii_to_hex(chunk))
  end
  key = chunks.map { |c| c[1] }.join
  message = strings_transpose(chunks.map { |c| c[0] }).join
  [message, key]
end

def base64_rkx_decode(file)
  rkx_decode(
    Base64.strict_decode64(
      File.readlines(file).map { |line| line.chomp }.join
    )
  )
end
