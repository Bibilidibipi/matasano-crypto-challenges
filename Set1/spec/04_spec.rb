require_relative "../04_detect_single_character_xor"

describe "detect_single_byte_xor" do
  it "decodes example" do
    file_path = File.expand_path("../txt/04_test.txt", File.dirname(__FILE__))
    ascii = "Now that the party is jumping\n"

    expect(detect_single_byte_xor(file_path)).to eq(ascii)
  end
end
