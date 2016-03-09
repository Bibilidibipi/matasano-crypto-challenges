def pkcs7_pad(message, length)
  pad_length = length - (message.length % length)
  message + pad_length.chr * pad_length
end

def pkcs7_unpad(message)
  pad_length = message[-1].ord
  message[0...(-1 * pad_length)]
end
