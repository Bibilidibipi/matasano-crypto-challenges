require_relative "../18_implement_ctr_the_stream_cipher_mode"

describe class CTR
  describe "#encrypt" do
    it "decrypts example" do
      cipher = "L77na/nrFsKvynd6HzOoG7GHTLXsTVu9qvY/2syLXzhPweyyMTJULu/6/kXX0KSvoOLSFQ=="
      key = "YELLOW SUBMARINE"
      expect(CTR.new.encrypt(cipher, key)).to eq "hi"
    end
  end
end
