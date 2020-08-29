require_relative "../18_implement_ctr_the_stream_cipher_mode"

describe class CTR
  describe "#encrypt" do
    it "decrypts example" do
      cipher = Base64.strict_decode64("L77na/nrFsKvynd6HzOoG7GHTLXsTVu9qvY/2syLXzhPweyyMTJULu/6/kXX0KSvoOLSFQ==")
      key = "YELLOW SUBMARINE"

      expect(CTR.new.encrypt(cipher, key, 0.chr * 8)).to eq "Yo, VIP Let's kick it Ice, Ice, baby Ice, Ice, baby "
    end
  end
end
