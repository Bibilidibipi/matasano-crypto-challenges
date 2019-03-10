require_relative "../Shared/Ciphers/single_char_xor"
require_relative "../Shared/hex"

def detect_single_byte_xor(file)
  Ciphers::SingleCharXor.decipher(
    File.readlines(file).map do |line|
      Hex.new(line.chomp).to_ascii
    end
  )
end
