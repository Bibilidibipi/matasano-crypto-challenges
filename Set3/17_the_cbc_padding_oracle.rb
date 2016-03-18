require_relative "../Set2/10_implement_cbc_mode"

class UserService3
  def initialize
    @key = rand_key
    @iv = rand_key
  end

  def get_code
    messages_path = File.expand_path("./txt/17_messages.txt", File.dirname(__FILE__))
    message = Base64.strict_decode64(File.readlines(messages_path).map(&:chomp).sample)
    [cbc_encrypt(message, key, iv), iv]
  end

  def valid_padding?(code, test_iv)
    valid_pkcs7_padding?(cbc_decrypt_nopad(code, key, test_iv))
  end

  private

  attr_accessor :key, :iv

  def rand_key
    r = ""
    16.times { r += rand(255).chr }
  
    r
  end

  def cbc_decrypt_nopad(code, key, test_iv)
    chunks = get_chunks(code, 16, false)
    message = ""
  
    chunks.each do |c|
      m = ascii_xor(aes_128_ecb_decrypt(c, key, true), test_iv)
      message += m
      test_iv = c
    end
  
    message
  end

  def valid_pkcs7_padding?(str)
    chr = str[-1]
    n = chr.ord

    str[(-1 * n)..-1] == chr * n
  end
end

class IncorrectPrevChar < StandardError; end

def get_char(prev_block, block, message, i, us, repeat)
  iv = prev_block.chars.reverse
  test_block = prev_block.dup
  test_block[14] = ascii_xor(test_block[14], 32.chr) if repeat
  test_block[(16 - i)..-1] = ascii_xor(prev_block[(16 - i)..-1], ascii_xor(message, (i + 1).chr * i))

  255.downto(0).each do |j|
    test_block[15 - i] = j.chr
    if us.valid_padding?(block, test_block)
      return (iv[i].ord ^ j ^ (i + 1)).chr
    end

    raise IncorrectPrevChar.new if j == 0
  end
end

def crack_block(prev_block, block, us)
  message = ""
  16.times do |i|
    begin
      message = get_char(prev_block, block, message, i, us, false) + message
    # first found char only
    rescue IncorrectPrevChar
      message = get_char(prev_block, block, "", 0, us, true)
      message = get_char(prev_block, block, message, i, us, false) + message
    end
  end

  message
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

def crack
  us = UserService3.new
  code, iv = us.get_code
  blocks = get_chunks(code, 16, false)
  message = ""
  blocks.length.times do |i|
    iv = blocks[i - 1] unless i == 0
    message += crack_block(iv, blocks[i], us)
  end

  pkcs7_unpad(message)
end
