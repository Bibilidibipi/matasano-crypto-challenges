require_relative "../01_convert_hex_to_base64"

describe "hex_to_ascii" do
  it "should convert example" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    ascii = "I'm killing your brain like a poisonous mushroom"

    expect(hex_to_ascii(hex)).to eq(ascii)
  end
end

describe "ascii_to_hex" do
  it "should convert example" do
    ascii = "I'm killing your brain like a poisonous mushroom"
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

    expect(ascii_to_hex(ascii)).to eq(hex)
  end
end

describe "hex_to_base64" do
  it "should convert example" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

    expect(hex_to_base64(hex)).to eq(base64)
  end
end
