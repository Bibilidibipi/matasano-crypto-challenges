require "base64"

def hex_to_ascii(hex)
  [hex].pack('H*')
end

def ascii_to_hex(ascii)
  ascii.chars.map do |c|
    c.ord.to_s(16).rjust(2, '0')
  end.join
end

def hex_to_base64(hex)
 Base64.strict_encode64(hex_to_ascii(hex))
end
