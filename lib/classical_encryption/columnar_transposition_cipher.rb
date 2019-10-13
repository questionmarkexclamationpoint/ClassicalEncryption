module ClassicalEncryption
  class ColumnarTranspositionCipher < Cipher
    def initialize(keys = 'CORRECT HORSE BATTERY STAPLE'.split.map(&:chars))
      super()
      @keys = keys.map(&:uniq)
      sorted_hash = @keys.map{|key| key.sort.each.with_index.inject({}){|hash, ki| k, i = ki; hash[k] = i; hash}}
      @key_hash = @keys.map.with_index{|key, i| key.each.with_index.inject({}){|hash, kj| k, j = kj; hash[sorted_hash[i][k]] = j; hash}}
    end
    def encrypt(plaintext)
      @keys.each do |key|
        rows = plaintext.chars.each_slice(key.length).to_a
        max_size = rows.max_by(&:length).length
        rows.each{|row| (max_size - row.length).times{row << plaintext.chars.sample}}
        plaintext = rows.transpose.sort_by.with_index{|row, i| key[i]}.flatten.join
      end
      plaintext
    end
    def decrypt(ciphertext)
      # DECRYPT BROKEN
      @keys.reverse.each.with_index do |key, i|
        columns = ciphertext.chars.each_slice(ciphertext.length / key.length).to_a
        ciphertext = columns.sort_by.with_index{|col, j| @key_hash[-i - 1][j]}.transpose.flatten.join
      end
      ciphertext
    end
    def optimal_plaintext_factor
      @opt ||= @keys.inject(1){|g, k| lcm(g, k.length)}
    end
    
    private
    
    def gcd(a, b)
      return b if a == 0
      gcd(b % a, a)
    end
    
    def lcm(a, b)
      a * b / gcd(a, b)
    end
  end
end