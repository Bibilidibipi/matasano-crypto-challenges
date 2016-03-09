require_relative "../11_ecb_cbc_detection_oracle"

describe "rand_ascii" do
  it "returns string of given length" do
    expect(rand_ascii(7).length).to eq(7)
  end
end

describe "ecb?" do
  it "detects half of codes as ecb" do
    message_path = File.expand_path("../txt/11_test_message.txt", File.dirname(__FILE__))
    message = File.readlines(message_path).map { |l| l.chomp }.join
    num_ecb = 0
    100.times do
      num_ecb += 1 if ecb?(aes_rand_encrypt_base64(message))
    end

    expect(num_ecb).to be_within(15).of(50)
  end
end
