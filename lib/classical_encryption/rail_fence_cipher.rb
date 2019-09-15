module ClassicalEncryption
  class RailFenceCipher < Cipher
    def initialize(height = 3)
      super()
      @height = height
      @half_height = (height - 1) / 2.0
      @amp = (@height - 1) / Math::PI
      @@half_pi = Math::PI / 2.0
    end
    def encrypt(plaintext)
      plaintext.chars
        .each
        .with_index
        .inject(@height.times.map{''}){|strs, ci| c, i = ci; strs[index(i)] += c; strs}
        .join
    end
    def decrypt(ciphertext)
      lengths = ciphertext.length.times.inject(Array.new(@height, 0)){|arr, i| arr[index(i)] += 1; arr}
      offset = 0
      rows = lengths.map{|l| s = ciphertext[offset..offset + l - 1]; offset += l; s.chars}
      ciphertext.length.times.inject(''){|s, i| s + rows[index(i)].shift}
    end
    
    private
    
    def index(i)
      i += @height - 1
      x = (@amp * Math.asin(Math.sin((i * @@half_pi) + @@half_pi)) + @half_height).round
      x
    end
  end
end