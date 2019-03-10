require_relative "../ascii"
require_relative "../ciphers"

module Ciphers
  class RepeatingKeyXor
    include Ciphers

    attr_reader :plain_text, :key

    def cipher_text
      @cipher_text ||= plain_text.each_char.with_index.map do |c, i|
        Ascii.new(c).xor(key[i % key.length]).ascii
      end.join
    end
  end
end
