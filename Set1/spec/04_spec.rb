require_relative "../04_detect_single_character_xor"

describe "problem 4" do
  it "deciphers example" do
    file_path = File.expand_path("../txt/04_test_code.txt", File.dirname(__FILE__))
    plain_text = "Now that the party is jumping\n"

    expect(detect_single_byte_xor(file_path)).to eq plain_text
  end
end
