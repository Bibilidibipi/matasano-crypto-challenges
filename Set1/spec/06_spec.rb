require_relative "../06_break_repeating_key_xor"

describe "normalized_hamming_distance" do
  it "raises error if given strings of different lengths" do
    s1 = "hello"
    s2 = "bye"
    error = "must compare strings of equal length"

    expect{normalized_hamming_distance(s1, s2)}.to raise_error(error)
  end

  it "calculates example" do
    s1 = "this is a test"
    s2 = "wokka wokka!!!"
    d = 37.fdiv(14)

    expect(normalized_hamming_distance(s1, s2)).to eq(d)
  end
end
