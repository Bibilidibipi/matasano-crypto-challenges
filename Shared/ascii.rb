require "base64"

class Ascii
  attr_reader :ascii

  class << self
    def all_chars
      (0..255).map { |i| i.chr }
    end
  end

  def initialize(ascii)
    @ascii = ascii
  end

  def to_hex
    @to_hex ||= ascii.chars.map do |c|
      c.ord.to_s(16).rjust(2, '0')
    end.join
  end

  def xor(ascii2)
    raise "length must match" unless ascii.length == ascii2.length

    xor = ascii.chars.zip(ascii2.chars).map do |a|
      (a[0].ord ^ a[1].ord).chr
    end.join

    self.class.new(xor)
  end

  def xor_char(char)
    xor = ascii.bytes.map { |b|
      (b ^ char.ord).chr
    }.join

    self.class.new(xor)
  end
end
