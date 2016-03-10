require_relative "../13_ecb_cut_and_paste.rb"

describe "create_admin" do
  it "creates admin" do
    expect(create_admin["role"]).to eq("admin")
  end
end
