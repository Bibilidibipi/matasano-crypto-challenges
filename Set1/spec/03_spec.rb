require_relative "../../Shared/xor_cipher"

describe "problem 3" do
  it "finds key" do
    cipher = Hex.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736").to_ascii
    key = "X"

    expect(XorCipher.new(cipher).key).to eq key
  end

  it "deciphers message" do
    cipher = Hex.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736").to_ascii
    message = "Cooking MC's like a pound of bacon"

    expect(XorCipher.new(cipher).message).to eq message
  end
end
