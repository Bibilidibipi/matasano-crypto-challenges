require_relative "./10_implement_cbc_mode"

class UserService2
  def initialize
    @key = rand_key
    @iv = rand_key
  end

  def create_ciphertext(user_data)
    encrypt(profile_str_for(user_data))
  end

  def parse_ciphertext(code)
    parse(decrypt(code))
  end

  private

  attr_accessor :key, :iv

  def rand_key
    r = ""
    16.times { r += rand(255).chr }

    r
  end

  def parse(str)
    h = {}
    pairs = []
    first = 0
    str.length.times do |i|
      if str[i] == ';' && str[i - 1] != "'"
        pairs << str[first...i]
        first = i + 1
      end
    end
    pairs << str[first..-1]

    pairs.each do |p|
      k, v = nil, nil
      p.length.times do |i|
        if p[i] == '=' && p[i - 1] != "'"
          k = p[0...i]
          v = p[(i + 1)..-1]
        end
      end
      h[k] = v
    end

    h
  end

  def profile_str_for(user_data)
    user_data.tr!("=", "'='")
    user_data.tr!(";", "';'")

    "comment1=cooking%20MCs;userdata=" + 
      user_data + 
      ";comment2=%20like%20a%20pound%20of%20bacon"
  end

  def encrypt(str)
    cbc_encrypt(str, key, iv)
  end

  def decrypt(code)
    cbc_decrypt(code, key, iv)
  end
end

def create_admin2
  us = UserService2.new
  code = us.create_ciphertext("hack")
  xor = Ascii.new("0like%20a%20").xor(";admin=true;").ascii
  code[32...44] = Ascii.new(code[32...44]).xor(xor).ascii
  
  us.parse_ciphertext(code)
end

