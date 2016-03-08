require "base64"
require "openssl"

def aes_128_ecb_decrypt(file)
  decrypter = OpenSSL::Cipher.new 'AES-128-ECB'
  decrypter.decrypt
  decrypter.key = "YELLOW SUBMARINE"

  code = Base64.strict_decode64(File.readlines(file).map { |l| l.chomp }.join)
  message = decrypter.update(code) + decrypter.final
end
