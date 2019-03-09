require_relative "../ascii"
require_relative "../ciphers"

module Ciphers
  class Xor
    include Ciphers

    attr_reader :cipher

    def initialize(cipher)
      @cipher = Ascii.new(cipher)
    end

    def message
      @message ||= decipher[0]
    end

    def key
      @key ||= decipher[1]
    end

    def score
      @score ||= decipher[2]
    end

    private

    def decipher
      @decipher ||= Ascii.all_chars.map { |c|
        xor = cipher.xor_char(c).ascii

        [xor, c, English.score(xor)]
      }.max_by{ |a| a[2] }
    end
  end
end
