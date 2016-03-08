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

describe "get_chunks" do
  let(:string) { "I am\nand you also are" }
  let(:length) { 6 }

  context "partials is false" do
    it "gets chunks of same length" do
      chunks = get_chunks(string, length, false)

      expect(chunks.length).to eq(3)
      expect(chunks.all? { |s| s.length == 6 }).to be true
    end
  end

  context "partials is true" do
    it "gets chunks of different length" do
      chunks = get_chunks(string, length, true)

      expect(chunks.length).to eq(4)
      expect(chunks[0...-1].all? { |s| s.length == 6 }).to be true
      expect(chunks[-1].length).to eq(3)
    end
  end
end

describe "keysize" do
  it "cracks example" do
    base64 = File.readlines("Set1/txt/06_test_code.txt").map { |l| l.chomp }.join
    code = Base64.strict_decode64(base64)

    expect(keysize(code)).to eq(10)
  end
end

describe "strings transpose" do
  it "transposes example" do
    a = ["hnr", "nle", "nrb", "zzz"]
    t = ["hnnz", "nlrz", "rebz"]

    expect(strings_transpose(a)).to eq(t)
    expect(strings_transpose(t)).to eq(a)
  end
end

describe "base64_rkx_decode" do
  it "cracks example" do
    code_path = File.expand_path(
      "../txt/06_test_code.txt", 
      File.dirname(__FILE__)
    )
    message_path = File.expand_path(
      "../txt/06_test_message.txt", 
      File.dirname(__FILE__)
    )
    
    message = File.readlines(message_path).join.chomp
    key = "ICEICEBABY"
    test_message, test_key = base64_rkx_decode(code_path)

    expect(test_message).to eq(message)
    expect(test_key).to eq(key)
  end
end
