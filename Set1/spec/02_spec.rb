require_relative "../02_fixed_xor"

describe "hex_a_xor_ascii" do
  it "converts example" do
    hex = "1c0111001f010100061a024b53535009181c"
    a = "w"
    ascii = "kvfwhvvwqmu<$$'~ok"

    expect(hex_a_xor_ascii(hex, a)).to eq(ascii)
  end
end

describe "a_xor_hex" do
  it "converts example" do
    a1 = "m"
    a2 = "P"
    hex = "3d"

    expect(a_xor_hex(a1, a2)).to eq(hex)
  end
end

describe "ascii_xor" do
  it "converts example" do
    ascii1 = "Yellow spider, yellow leaf....."
    ascii2 = ":\n\x02\n\x06\x05M\x00P\x04\x1DE\x16IE\t\x00\x1F\x18O\x1FE\x00\x01A\x04KBGKH" 
    ascii3 = "confirms my deepest held belief"

    expect(ascii_xor(ascii1, ascii2)).to eq(ascii3)
  end
end

describe "hex_xor" do
  it "converts example" do
    hex1 = "1c0111001f010100061a024b53535009181c"
    hex2 = "686974207468652062756c6c277320657965"
    hex3 = "746865206b696420646f6e277420706c6179"

    expect(hex_xor(hex1, hex2)).to eq(hex3)
  end
end
