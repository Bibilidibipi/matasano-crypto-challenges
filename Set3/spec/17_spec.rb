require_relative "../17_the_cbc_padding_oracle"

describe "crack" do
  it "finds message" do
    messages_path = File.expand_path("../txt/17_messages.txt", File.dirname(__FILE__))
    messages = File.readlines(messages_path).map { |l| Base64.strict_decode64(l.chomp) }

    expect(messages).to include(crack)
  end
end
