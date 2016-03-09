require_relative "../Set1/06_break_repeating_key_xor"
require_relative "../Set1/07_aes_in_ecb_mode"
require_relative "./09_implement_pkcs#7_padding"

def cbc_encrypt(message, key, iv)
  chunks = get_chunks(pkcs7_pad(message, 16), 16, false)
  code = ""
  chunks.each do |c|
    iv = aes_128_ecb_encrypt(ascii_xor(c, iv), key, true)
    code += iv
  end
  
  code
end

def cbc_decrypt(code, key, iv)
  chunks = get_chunks(code, 16, false)
  message = ""

  chunks.each do |c|
    m = ascii_xor(aes_128_ecb_decrypt(c, key, true), iv)
    message += m
    iv = c
  end

  pkcs7_unpad(message)
end

def cbc_decrypt_file(file, key, iv)
  code = Base64.strict_decode64(File.readlines(file).map { |l| l.chomp }.join)
  cbc_decrypt(code, key, iv)
end
