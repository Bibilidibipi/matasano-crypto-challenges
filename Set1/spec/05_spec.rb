require_relative "../05_repeating_key_xor"

describe "vigenere_encrypt" do
  it "encrypts example" do
    message = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    key = "ICE"
    output = "\v67'*+.cb,.ii*#i:*<c$ -b=c4<*&\"c$''e'*(+/ C
e.,e*1$3:e>+ 'ci+ (1e(c&0.'(/"

    expect(vigenere_encrypt(message, key)).to eq(output)
  end
end
