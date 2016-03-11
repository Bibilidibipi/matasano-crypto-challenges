require_relative "../16_cbc_bitflipping_attacks"

describe "create_admin2" do
  it "creates admin" do
    expect(create_admin2["admin"]).to eq("true")
  end
end
