require "base64"
require "openssl"

def aes_128_ecb_decrypt_file(file, key)
  code = Base64.strict_decode64(File.readlines(file).map { |l| l.chomp }.join)
  aes_128_ecb_decrypt(code, key, false)
end

def aes_128_ecb_decrypt(code, key, block)
  decrypter = OpenSSL::Cipher.new 'AES-128-ECB'
  decrypter.decrypt
  decrypter.key = key
  decrypter.padding = 0 if block

  decrypter.update(code) + decrypter.final
end

def aes_128_ecb_encrypt(message, key, block)
  encrypter = OpenSSL::Cipher.new 'AES-128-ECB'
  encrypter.encrypt
  encrypter.key = key
  encrypter.padding = 0 if block 

  encrypter.update(message) + encrypter.final
end
