require_relative "../english"

describe English do
  describe "::score" do
    it "normalizes on length" do
      ascii = "hello"

      expect(described_class.score(ascii * 2)).to eq described_class.score(ascii)
    end

    it "discounts non-english characters" do
      ascii1 = "'\r\\\e"
      ascii2 = "hello"

      expect(described_class.score(ascii1)).to be < described_class.score(ascii2)
    end
  end
end
