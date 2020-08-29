require_relative "../Shared/Ciphers/repeating_key_xor"
require_relative "./18_implement_ctr_the_stream_cipher_mode"

class UserService4
  attr_writer :plaintexts
  attr_reader :iv

  def initialize
    @key = rand_key
    @iv = 0.chr * 8
  end

  def plaintexts
    return @plaintexts if @plaintexts

    plaintexts_base64_path = File.expand_path("./txt/19_plaintexts_base64.txt", File.dirname(__FILE__))

    self.plaintexts = File.readlines(plaintexts_base64_path).map do |plaintext_base64|
      Base64.strict_decode64(plaintext_base64.chomp)
    end
  end

  def ciphers
    ctr = CTR.new

    plaintexts.map do |plaintext|
      ctr.encrypt(plaintext, key, iv)
    end
  end

  def break_fixed_nonce(ciphers)
    ciphers_array = ciphers.map do |cipher|
      cipher.split('')
    end
    lengths_array = ciphers_array.map(&:length)
    max_cipher_length = ciphers_array.max_by(&:length).length

    cipher_blocks = ([nil] * max_cipher_length).zip(*ciphers_array).map(&:join)
    cipher_blocks_ciphers = cipher_blocks.map do |block|
      Ciphers::SingleCharXor.new(cipher_text: block)
    end
    plain_text_blocks = cipher_blocks_ciphers.map(&:plain_text)
    if plain_text_blocks.first.split('').all? { |c| c == c.downcase }
      plain_text_blocks.first.upcase!
    end

    transpose(plain_text_blocks, lengths_array)
  end


  private

  attr_reader :key

  def rand_key
    r = ""
    16.times { r += rand(255).chr }
  
    r
  end

  def transpose(strings_array, lengths_array)
    transposed_array = Array.new(lengths_array.length) {''}

    lengths_array.each_with_index do |length, lengths_i|
      strings_array.first(length).each_with_index do |s, i|
        transposed_array[lengths_i] += s[0]
          strings_array[i] = s[1..-1]
      end
    end

    transposed_array
  end
end

