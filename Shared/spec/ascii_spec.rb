require_relative "../ascii.rb"

describe Ascii do
  describe "#to_hex" do
    it "converts example" do
      ascii = described_class.new("I'm killing your brain like a poisonous mushroom")
      message = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

      expect(ascii.to_hex).to eq(message)
    end
  end

  describe "#xor" do
    it "converts example" do
      ascii = described_class.new("Yellow spider, yellow leaf.....")
      ascii_string = ":\n\x02\n\x06\x05M\x00P\x04\x1DE\x16IE\t\x00\x1F\x18O\x1FE\x00\x01A\x04KBGKH" 
      message = "confirms my deepest held belief"

      expect(ascii.xor(ascii_string).ascii).to eq(message)
    end
  end
end
