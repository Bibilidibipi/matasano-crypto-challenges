require_relative "../19_break_fixed_nonce_ctr_mode_using_substitutions"

describe class UserService4
  describe "break_fixed_nonce" do
    it "decrypts example file" do
      user_service_4 = UserService4.new
      plaintexts = user_service_4.plaintexts
      ciphers = user_service_4.ciphers

      expect(user_service_4.break_fixed_nonce(ciphers.map do |el| el[0..29] end)).to eq (plaintexts.map do |el| el[0..29] end)
    end
  end
end

