require_relative "../ascii"
require_relative "../ciphers"
require_relative "../english"

module Ciphers
  class SingleCharXor
    include Ciphers

    attr_reader :cipher_text

    def plain_text
      @plain_text ||= decipher[:plain_text]
    end

    def key
      @key ||= decipher[:key]
    end


    private

    def decipher
      @decipher ||= Ascii.all_chars.map { |c|
        xor = Ascii.new(cipher_text).xor_char(c).ascii

        { plain_text: xor, key: c }
      }.max_by{ |h| English.score(h[:plain_text])}
    end
  end
end
