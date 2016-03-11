# Takes a cipher that prepends a random string and then your own plaintext to 
# the message before encryption
# The random string must have a random length that varies at least the block length
class BreakECB2
  ENG_ORDER = 
    [32] + 
    (97..122).to_a + 
    (65..90).to_a + 
    (0..31).to_a + 
    (33..64).to_a + 
    (91..96).to_a + 
    (123..255).to_a

  def initialize(&prc)
    @cipher = prc
    @block_size, @encrypt_As = get_info
  end

  def crackECB
    raise "not an ECB cipher" unless ecb?

    message = ""
    message_extra = 0

    loop do
      found = false
      pre_pend = "B" + "A" * block_size + "B" * (block_size - message_extra - 1)
      add = ((pre_pend + message).length - 1) / block_size
      char_chunk, last = get_test_chunk(pre_pend, add)
     
      ENG_ORDER.each do |ord|
        test_chr = ord.chr
        test_chunk = get_test_chunk(pre_pend + message + test_chr, add)[0]
        test_chunk
        if test_chunk == char_chunk
          test_chr
          message += test_chr
          message_extra = (message_extra + 1) % block_size

          return unpad(message) if ord == 1 && last
          break
        end
      end
    end
  end

  private

  attr_accessor :cipher, :block_size, :encrypt_As

  def get_info
    code = cipher.call("A" * 95)
    4.upto(32).each do |s|
      chunks = get_chunks(code, s)
      chunks.each_index do |i|
        return [s, chunks[i]] if chunks[i] == chunks[i + 1]
      end
    end

    raise "block size greater than 32"
  end
  
  def get_chunks(str, length)
    chunks = []
    i = 0
    until i >= str.length
      chunks << str[i...(i + length)]
      i += length
    end

    chunks
  end

  def ecb?
    code = cipher.call("A" * 1024)
    chunks = get_chunks(code, block_size)
    chunks.uniq.length != chunks.length
  end

  def get_test_chunk(str, add)
    while true
      code = cipher.call(str)
      chunks = get_chunks(code, block_size)
      chunks.each_index do |i|
        if chunks[i] == encrypt_As
          last = i + add == chunks.length - 1
          return [chunks[i + add], last] 
        end
      end
    end
  end

  def unpad(str)
    pad_length = str[-1].ord
    str[0...(-1 * pad_length)]
  end  
end
