require_relative "../../Shared/Ciphers/repeating_key_xor"

describe "problem 5" do
  it "encrypts example" do
    plain_text = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    key = "ICE"
    cipher_text = "\v67'*+.cb,.ii*#i:*<c$ -b=c4<*&\"c$''e'*(+/ C
e.,e*1$3:e>+ 'ci+ (1e(c&0.'(/"

    expect(Ciphers::RepeatingKeyXor.new(plain_text: plain_text, key: key).cipher_text).to eq cipher_text
  end
end
