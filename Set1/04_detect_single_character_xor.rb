require_relative "../Shared/xor_cipher"
require_relative "../Shared/hex"

def detect_single_byte_xor(file)
  XorCipher.decipher(
    File.readlines(file).map do |line|
      Hex.new(line.chomp).to_ascii
    end
  )
end
