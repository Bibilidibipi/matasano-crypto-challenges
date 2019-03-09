module Ciphers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def decipher(cipher_lines)
      cipher_lines.map { |line|
        self.new(line)
      }.max_by { |cipher|
        cipher.score
      }.message
    end
  end

  def message
    raise "not implemented"
  end

  def score
    raise "not implemented"
  end
end
