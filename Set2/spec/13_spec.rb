require_relative "../13_ecb_cut_and_paste.rb"

describe "create_admin1" do
  it "creates admin" do
    expect(create_admin1["role"]).to eq("admin")
  end
end
