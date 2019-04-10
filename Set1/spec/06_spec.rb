require_relative "../../Shared/Ciphers/repeating_key_xor"

describe "repeating_key_xor_cipher" do
  let(:cipher_text_file_path) {
    File.expand_path(
      "../txt/06_test_code.txt", 
      File.dirname(__FILE__)
    )
  }
  let(:cipher) {
    Ciphers::RepeatingKeyXor.new(
      cipher_text: Base64.strict_decode64(
        File.readlines(cipher_text_file_path).map { |line| line.chomp }.join
      )
    )
  }

  it "finds plain_text" do
    plain_text_file_path = File.expand_path(
      "../txt/06_test_message.txt", 
      File.dirname(__FILE__)
    )
    plain_text = File.readlines(plain_text_file_path).join.chomp

    expect(cipher.plain_text).to eq(plain_text)
  end

  it "finds key" do
    key = "ICEICEBABY"

    expect(cipher.key).to eq(key)
  end
end
