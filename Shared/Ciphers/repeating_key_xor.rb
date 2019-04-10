require_relative "../ascii"
require_relative "../ciphers"

module Ciphers
  class RepeatingKeyXor
    include Ciphers

    MAX_KEYSIZE = 40.freeze

    def cipher_text
      @cipher_text ||= plain_text.each_char.with_index.map do |c, i|
        Ascii.new(c).xor(key[i % key.length]).ascii
      end.join
    end

    def plain_text
      @plain_text ||= decipher[:plain_text]
    end

    def key
      @key ||= decipher[:key]
    end


    private

    def decipher
      return @decipher if @decipher

      blocks = strings_transpose(Ascii.new(cipher_text).split_chunks(length: keysize, partials: true))
      blocks.map! do |block|
        Ciphers::SingleCharXor.new(cipher_text: block)
      end
      key = blocks.map { |block| block.key }.join
      plain_text = strings_transpose(blocks.map { |block| block.plain_text}).join

      @decipher = { plain_text: plain_text, key: key }
    end

    def keysize
      size = 0
      distance = 9

      (2..MAX_KEYSIZE).each do |test_size|
        chunks = Ascii.new(cipher_text).split_chunks(length: test_size)
        chunks.pop if chunks.length.odd?
        break if chunks.empty?
        average_distance = average_hamming_distance(chunks)
        if average_distance < distance - 1 || 
            (average_distance < distance && test_size % size != 0) || 
            (average_distance < distance && size == 2)
          distance = average_distance
          size = test_size
        end
      end

      raise "keylength can't be 0" if size.zero?

      size
    end

    def average_hamming_distance(array)
      array.each_slice(2)
        .to_a
        .map { |ascii1, ascii2|
        Ascii.new(ascii1).normalized_hamming_distance(ascii2)
      }
        .inject(:+)
        .fdiv(array.length) * 2
    end

    def strings_transpose(array)
      chars_array = array.map { |string|
        string.chars
      }

      chars_array[0].zip(*chars_array[1..-1]).map { |chars|
        chars.join
      }
    end
  end
end
