require_relative "../07_aes_in_ecb_mode"

describe "aes_128_ecb_decrypt_file" do
  it "decrypts example" do
    file_path = File.expand_path("../txt/07_code.txt", File.dirname(__FILE__))
    message_path = File.expand_path("../txt/07_message.txt", File.dirname(__FILE__)) 
    message = File.readlines(message_path).join.chomp

    test_message = aes_128_ecb_decrypt_file(file_path, "YELLOW SUBMARINE")

    expect(test_message).to eq(message)
  end
end

describe "aes_128_ecb_encrypt" do
  it "encrypts example" do
    file_path = File.expand_path("../txt/07_code.txt", File.dirname(__FILE__))
    message_path = File.expand_path("../txt/07_message.txt", File.dirname(__FILE__))
    message = File.readlines(message_path).join.chomp
    code = Base64.strict_decode64(File.readlines(file_path).map { |l| l.chomp }.join)

    test_code = aes_128_ecb_encrypt(message, "YELLOW SUBMARINE", false)

    expect(test_code).to eq(code)
  end
end
