require_relative "../03_single_byte_xor_cipher"

describe "score_english" do
  it "normalizes on length" do
    ascii = "hello"

    expect(score_english(ascii * 2)).to eq score_english(ascii)
  end

  it "discounts non-english characters" do
    ascii1 = "'\r\\\e"
    ascii2 = "hello"

    expect(score_english(ascii1)).to be < score_english(ascii2)
  end
end

describe "hex_decode_xor_ascii" do
  it "decodes example" do
    hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    ascii = "Cooking MC's like a pound of bacon"

    expect(hex_decode_xor_ascii(hex)).to eq(ascii)
  end
end
