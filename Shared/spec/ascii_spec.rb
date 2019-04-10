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

  describe "#split_chunks" do
    let(:ascii) { described_class.new("I am\nand you also are") }
    let(:length) { 6 }

    context "partials is false" do
      it "gets chunks of same length" do
        chunks = ascii.split_chunks(length: length)

        expect(chunks.length).to eq(ascii.ascii.length / length)
        expect(chunks.all? { |chunk| chunk.length == length }).to be true
      end
    end

    context "partials is true" do
      it "gets chunks of different length" do
        chunks = ascii.split_chunks(length: length, partials: true)

        expect(chunks.length).to eq(((ascii.ascii.length - 1) / length) + 1)
        expect(chunks[0...-1].all? { |chunk| chunk.length == length }).to be true
        expect(chunks[-1].length).to eq(ascii.ascii.length % length)
      end
    end
  end

  describe "#normalized_hamming_distance" do
    it "raises error if given string of different length" do
      ascii = described_class.new("hello")
      ascii_2 = "bye"
      error = "must compare strings of equal length"

      expect{ascii.normalized_hamming_distance(ascii_2)}.to raise_error(error)
    end

    it "calculates example" do
      ascii = described_class.new("this is a test")
      ascii_2 = "wokka wokka!!!"
      distance = 37.fdiv(14)

      expect(ascii.normalized_hamming_distance(ascii_2)).to eq(distance)
    end
  end
end
