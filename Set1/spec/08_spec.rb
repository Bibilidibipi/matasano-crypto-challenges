require_relative "../08_detect_aes_in_ecb_mode"

describe "detect_aes_ecb" do
  it "finds encrypted example" do
    file_path = File.expand_path("../txt/08_code.txt", File.dirname(__FILE__))

    expect(detect_aes_ecb(file_path)).to eq(132)
  end
end
