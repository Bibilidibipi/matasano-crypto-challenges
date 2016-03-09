require_relative "../09_implement_pkcs#7_padding"

describe "pkcs7_pad" do
  context "when block size divides message length" do
    it "pads message with a block" do
      message = "I do not exist"
      block_size = 7

      expect(pkcs7_pad(message, block_size)).to eq("I do not exist\x07\x07\x07\x07\x07\x07\x07")
    end
  end

  context "when block size does no divide message length" do
    it "pads example" do
      message = "Only you exist"
      block_size = 6

      expect(pkcs7_pad(message, block_size)).to eq("Only you exist\x04\x04\x04\x04")
    end
  end
end

describe "pkcs7_unpad" do
  it "unpads example" do
    message = "Only you exist\x04\x04\x04\x04"

    expect(pkcs7_unpad(message)).to eq("Only you exist")
  end
end
