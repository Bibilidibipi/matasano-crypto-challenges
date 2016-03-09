require_relative "../10_implement_cbc_mode.rb"

describe "cbc_decrypt_file" do
  it "decrypts example" do
    file_path = File.expand_path("../txt/10_test_code.txt", File.dirname(__FILE__))
    message = "I do not exist, only you exist"
    key = "YELLOW SUBMARINE"
    iv = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
    test_message = cbc_decrypt_file(file_path, key, iv)

    expect(test_message).to eq(message)
  end
end
