require_relative "../Set1/07_aes_in_ecb_mode.rb"

class UserService
  def initialize
    @key = rand_key
    @uid = 0
  end

  def create_ciphertext(address)
    encrypt(profile_str_for(address))
  end

  def parse_ciphertext(code)
    parse(decrypt(code))
  end

  private

  attr_accessor :key, :uid

  def rand_key
    r = ""
    16.times { r += rand(255).chr }
  
    r
  end  
  
  def next_uid
    (self.uid = uid + 1).to_s
  end

  def parse(str)
    h = {}
    pairs = str.split("&")
    pairs.each do |p|
      k, v = p.split("=")
      h[k] = v
    end
  
    h
  end
  
  def profile_str_for(address)
    address.tr!("=&", "")
    "email=" + address + "&uid=" + next_uid + "&role=user"
  end
  
  def encrypt(str)
    aes_128_ecb_encrypt(str, key, false)
  end
  
  def decrypt(str)
    aes_128_ecb_decrypt(str, key, false)
  end
end

def create_admin
  us = UserService.new
  pre_code = us.create_ciphertext("me@myselfi.org")[0..31]
  admin_code = us.create_ciphertext("hackerswinadmin\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b")[16..31]

  us.parse_ciphertext(pre_code + admin_code) 
end
