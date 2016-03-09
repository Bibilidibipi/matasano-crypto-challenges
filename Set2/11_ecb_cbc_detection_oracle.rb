require_relative "../Set1/07_aes_in_ecb_mode"
require_relative "./10_implement_cbc_mode"

def rand_ascii(n)
  r = ""
  n.times { r += rand(255).chr }

  r
end

def aes_rand_encrypt_base64(message)
  message = rand_ascii(rand(6) + 5) + message + rand_ascii(rand(6) + 5)
  key = rand_ascii(16)
  if rand(2) == 0
    #ecb
    Base64.strict_encode64(aes_128_ecb_encrypt(message, key, false))
  else
    #cbc
    iv = rand_ascii(16)
    Base64.strict_encode64(cbc_encrypt(message, key, iv))
  end
end

def ecb?(code)
  code = Base64.strict_decode64(code)
  chunks = get_chunks(code, 16, false)
  chunks.uniq.length != chunks.length
end
