require_relative "../Shared/Ciphers/repeating_key_xor"
require_relative "../Set1/07_aes_in_ecb_mode"
require_relative "./09_implement_pkcs#7_padding"

def cbc_encrypt(message, key, iv)
  chunks = Ascii.new(pkcs7_pad(message, 16)).split_chunks(length: 16, partials: false)
  code = ""
  chunks.each do |c|
    iv = aes_128_ecb_encrypt(Ascii.new(c).xor(iv).ascii, key, true)
    code += iv
  end
  
  code
end

def cbc_decrypt(code, key, iv)
  chunks = Ascii.new(code).split_chunks(length: 16, partials: false)
  message = ""

  chunks.each do |c|
    m = Ascii.new(aes_128_ecb_decrypt(c, key, true)).xor(iv)
    message += m.ascii
    iv = c
  end

  pkcs7_unpad(message)
end

def cbc_decrypt_file(file, key, iv)
  code = Base64.strict_decode64(File.readlines(file).map { |l| l.chomp }.join)
  cbc_decrypt(code, key, iv)
end
