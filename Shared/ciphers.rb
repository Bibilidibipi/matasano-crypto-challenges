module Ciphers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def decipher(cipher_text_lines)
      cipher_text_lines.map { |line|
        self.new(cipher_text: line)
      }.max_by { |cipher|
        cipher.score
      }.plain_text
    end
  end

  def initialize(cipher_text: nil, key: nil, plain_text: nil)
    raise "must be initialized with cipher_text or plain_text, not both" unless !!cipher_text ^ !!plain_text

    @cipher_text = cipher_text if cipher_text
    @key = key if key
    @plain_text = plain_text if plain_text
  end

  def cipher_text
    raise "not implemented"
  end

  def plain_text
    raise "not implemented"
  end

  def score
    @score ||= English.score plain_text
  end
end
