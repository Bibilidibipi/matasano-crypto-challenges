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

  def xor(ascii_2)
    validate_matching_length(ascii_2)

    xor = ascii.chars.zip(ascii_2.chars).map do |a|
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

  def split_chunks(length:, partials: nil)
    ascii.scan(Regexp.new("[\\s\\S]{#{'1,' if partials}#{length}}"))
  end

  def normalized_hamming_distance(ascii_2)
    validate_matching_length(ascii_2)

    distance = 0
    ascii.chars.zip(ascii_2.chars).each do |a|
      distance += (a[0].ord ^ a[1].ord).to_s(2).count('1')
    end

    distance.fdiv(ascii.length)
  end

  def validate_matching_length(ascii_2)
    raise "must compare strings of equal length" unless ascii.length == ascii_2.length
  end
end
