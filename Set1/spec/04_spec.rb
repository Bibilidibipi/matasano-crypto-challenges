require_relative "../04_detect_single_character_xor"

describe "detect_single_byte_xor" do
  it "decodes example" do
    file = "Set1/txt/04_test.txt"
    ascii = "Now that the party is jumping\n"

    expect(detect_single_byte_xor(file)).to eq(ascii)
  end
end
