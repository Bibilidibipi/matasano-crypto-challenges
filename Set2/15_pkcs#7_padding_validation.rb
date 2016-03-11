def strip_padding(str)
  last = str[-1]
  n = last.ord
  padding = last * n
  
  raise "invalid pkcs7 padding" unless str[(-1 * n)..-1] == padding

  str[0...(-1 * n)]
end
