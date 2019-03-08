require_relative "../hex.rb"

describe Hex do
  describe "#to_ascii" do
    it "converts example" do
      hex = described_class.new("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
      message = "I'm killing your brain like a poisonous mushroom"

      expect(hex.to_ascii).to eq(message)
    end
  end

  describe "#to_base64" do
    it "converts example" do
      hex = described_class.new("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
      base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

      expect(hex.to_base64).to eq(base64)
    end
  end

  describe "#xor" do
    it "converts example" do
      hex = described_class.new("1c0111001f010100061a024b53535009181c")
      hex_string = "686974207468652062756c6c277320657965"
      xor = "746865206b696420646f6e277420706c6179"

      expect(hex.xor(hex_string).hex).to eq(xor)
    end
  end

  describe "#xor_char" do
    it "converts example" do
      hex = described_class.new("1c0111001f010100061a024b53535009181c")
      char = "w"
      xor = "6b76667768767677716d753c2424277e6f6b"

      expect(hex.xor_char(char).hex).to eq(xor)
    end
  end
end
