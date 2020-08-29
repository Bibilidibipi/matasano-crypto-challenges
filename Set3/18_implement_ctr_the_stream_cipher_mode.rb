require_relative "../Set1/07_aes_in_ecb_mode"

class CTR
  def encrypt(message, key, iv)
    keystream = ""
    num_blocks = ((message.length - 1) / 16) + 1

    num_blocks.times do |i|
      keystream += aes_128_ecb_encrypt(iv + [i].pack('Q<'), key, true)
    end

    Ascii.new(message).xor(keystream.slice(0...message.length)).ascii
  end
end
