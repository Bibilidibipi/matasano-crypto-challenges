require_relative "../Set1/07_aes_in_ecb_mode"

class CTR
  def encrypt(message, key)
    keystream = ""
    num_blocks = ((message.length - 1) / 16) + 1

    num_blocks.times do |i|
      keystream += aes_128_ecb_encrypt([0, i].pack('Q<*'), key, true)
    end

    ascii_xor(message, keystream)
  end
end
