require_relative "../11_ecb_cbc_detection_oracle" # for rand_ascii
require_relative "../12_byte_at_a_time_ecb_decryption_simple"

describe "BreakECB" do
  it "cracks example" do
    key = rand_ascii(16)
    message_path = File.expand_path("../txt/12_message.txt", File.dirname(__FILE__))
    message = Base64.strict_decode64(
      File.readlines(message_path).map { |l| l.chomp }.join
    )
    cipher = Proc.new do |pre_pend|
      plaintext = pre_pend + message
      aes_128_ecb_encrypt(plaintext, key, false)
    end

    cracker = BreakECB.new &cipher
    
    expect(cracker.crackECB).to eq(message)
  end
end
