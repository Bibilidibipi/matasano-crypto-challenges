require_relative "../../Shared/Ciphers/single_char_xor"

describe "problem 3" do
  let(:cipher_text) { Hex.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736").to_ascii }
  let(:cipher) { Ciphers::SingleCharXor.new(cipher_text: cipher_text) }
  let(:key) { "X" }
  let(:plain_text) { "Cooking MC's like a pound of bacon" }

  it "finds key" do
    expect(cipher.key).to eq key
  end

  it "deciphers message" do
    expect(cipher.plain_text).to eq plain_text
  end
end
