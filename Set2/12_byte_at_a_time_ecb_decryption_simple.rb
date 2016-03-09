# takes a cipher that prepends your own plaintext to the message before encryption
class BreakECB
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
    @block_size = get_block_size
  end

  def crackECB
    raise "not an ECB cipher" unless ecb?

    code = cipher.call("")
    length = get_chunks(code, block_size).length

    unpad(crack_upto_block(length - 1))
  end

  private

  attr_accessor :cipher, :block_size

  def get_block_size
    prev = ""
    1.upto(33).each do |i|
      new = cipher.call("A" * i)
      return i - 1 if new[0..(i - 2)] == prev[0..(i - 2)]
      prev = new
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

  def crack_upto_block(n)
    return "" if n == -1
    message = crack_upto_block(n - 1)

    (block_size - 1).downto(0) do |i|
      pre_pend = "A" * i
      code_block = cipher.call(pre_pend)[(n * block_size)...((n + 1) * block_size)]
      ENG_ORDER.each do |ord|
        test_chr = ord.chr
        if cipher.call(pre_pend + message + test_chr)[(n * block_size)...((n + 1) * block_size)] == code_block          
          message += test_chr
          break
        end
      end
    end

    message
  end

  def unpad(str)
    pad_length = str[-1].ord
    str[0...(-1 * pad_length)]
  end
end

