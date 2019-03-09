require_relative "ascii"

class XorCipher
  attr_reader :cipher

  class << self
    def decipher(cipher_lines)
      cipher_lines.map { |line|
        self.new(line)
      }.max_by { |xor_cipher|
        xor_cipher.score
      }.message
    end
  end

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
