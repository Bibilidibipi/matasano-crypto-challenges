require_relative "../07_aes_in_ecb_mode"

describe "aes_128_ecb_decrypt" do
  it "decrypts example" do
    file_path = File.expand_path("../txt/07_code.txt", File.dirname(__FILE__))
    message_path = File.expand_path("../txt/07_message.txt", File.dirname(__FILE__))
    
    message = File.readlines(message_path).join.chomp
    test_message = aes_128_ecb_decrypt(file_path)

    expect(test_message).to eq(message)
  end
end
