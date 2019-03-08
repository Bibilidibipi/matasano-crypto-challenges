require_relative "../../Shared/hex.rb"

describe "problem 1" do
  it "xors example" do
    hex = Hex.new("1c0111001f010100061a024b53535009181c")
    hex_string = "686974207468652062756c6c277320657965"
    xor = "746865206b696420646f6e277420706c6179"

    expect(hex.xor(hex_string).hex).to eq xor
  end
end
