require_relative "./02_fixed_xor"

# ascii to hex
def vigenere_encrypt_hex(message, key)
  i = -1
  message.chars.map do |c|
    a_xor_hex(c, key[i = (i + 1) % key.length])
  end.join
end

# ascii to ascii
def vigenere_encrypt(message, key)
  hex_to_ascii(vigenere_encrypt_hex(message, key))
end
