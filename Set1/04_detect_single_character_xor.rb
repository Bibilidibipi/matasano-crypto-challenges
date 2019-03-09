require_relative "../Shared/Ciphers/xor"
require_relative "../Shared/hex"

def detect_single_byte_xor(file)
  Ciphers::Xor.decipher(
    File.readlines(file).map do |line|
      Hex.new(line.chomp).to_ascii
    end
  )
end
