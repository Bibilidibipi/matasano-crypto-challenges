require_relative "../15_pkcs#7_padding_validation"

describe "strip_padding" do
  it "strips valid padding" do
    expect(strip_padding("ICE ICE BABY\x04\x04\x04\x04")).to eq("ICE ICE BABY")
  end

  it "raises error on invalid padding" do
    bad1 = "ICE ICE BABY\x05\x05\x05\x05"
    bad2 = "ICE ICE BABY\x01\x02\x03\x04"

    expect { strip_padding(bad1) }.to raise_error("invalid pkcs7 padding")
    expect { strip_padding(bad2) }.to raise_error("invalid pkcs7 padding")
  end
end
