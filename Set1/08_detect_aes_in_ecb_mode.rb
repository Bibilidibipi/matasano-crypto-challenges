def detect_aes_ecb(file)
  repeats = 0
  line_number = nil

  File.readlines(file).each_with_index do |line, i|
    chunks = line.chomp.scan(/.{32}/)
    test_repeats = chunks.length - chunks.uniq.length
    if test_repeats > repeats
      repeats = test_repeats
      line_number = i
    end
  end

  line_number
end
