require_relative "../ascii"
require_relative "../ciphers"

module Ciphers
  class SingleCharXor
    include Ciphers

    attr_reader :cipher_text

    def plain_text
      @plain_text ||= decipher[0]
    end

    def key
      @key ||= decipher[1]
    end


    private

    def decipher
      @decipher ||= Ascii.all_chars.map { |c|
        xor = Ascii.new(cipher_text).xor_char(c).ascii

        [xor, c]
      }.max_by{ |a| English.score(a[0]) }
    end
  end
end
