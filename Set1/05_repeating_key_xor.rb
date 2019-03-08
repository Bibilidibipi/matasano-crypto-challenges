require_relative "../Shared/ascii"
require_relative "../Shared/hex"

# ascii to hex
def vigenere_encrypt_hex(message, key)
  Ascii.new(vigenere_encrypt(message, key)).to_hex
end

# ascii to ascii
def vigenere_encrypt(message, key)
  message.each_char.with_index.map do |c, i|
    Ascii.new(c).xor(key[i % key.length]).ascii
  end.join
end
