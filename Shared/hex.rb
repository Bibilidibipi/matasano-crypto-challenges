require_relative "ascii"
require "base64"

class Hex
  attr_reader :hex, :to_ascii, :to_base64

  def initialize(hex)
    @hex = hex
  end

  def to_ascii
    @to_ascii ||= [hex].pack('H*')
  end

  def to_base64
    @to_base64 ||= Base64.strict_encode64(to_ascii)
  end

  def xor(hex2)
    raise "length must match" unless hex.length == hex2.length

    xor = Ascii.new(to_ascii)
      .xor(Hex.new(hex2).to_ascii)
      .to_hex

    self.class.new(xor)
  end

  def xor_char(char)
    xor = to_ascii.bytes.map { |b|
      (b ^ char.ord).chr
    }.join

    self.class.new(Ascii.new(xor).to_hex)
  end
end
