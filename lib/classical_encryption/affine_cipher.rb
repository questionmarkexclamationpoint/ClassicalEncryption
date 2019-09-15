module ClassicalEncryption
  class AffineCipher < Cipher
    def initialize(coefficient = 5, offset = 8, alphabet = ('a'..'z').to_a << ' ')
      raise ArgumentError if !Cipher.coprime?(coefficient, alphabet.length)
      super(alphabet)
      @offset = offset
      @coefficient = coefficient
    end
    def encrypt(plaintext)
      filter(plaintext)
        .chars
        .map{|c| @alphabet[(@coefficient * @alphabet_hash[c] + @offset) % @alphabet.length]}
        .join('')
    end
    def decrypt(ciphertext)
      ciphertext
        .chars
        .map do |c|
          index = AffineCipher.modular_inverse(@coefficient, @alphabet.length) 
          index *= (@alphabet_hash[c] - @offset) 
          index %= @alphabet.length
          @alphabet[index].chr
        end
        .join('')
    end
    
    private
    
    def self.modular_inverse(a, b)
      t = 0
      new_t = 1
      r = b
      new_r = a
      while new_r != 0 do
        quotient = (r / new_r).floor
        t, new_t = new_t, t - quotient * new_t
        r, new_r = new_r, r - quotient * new_r
      end
      return nil if r > 1
      t = t + b if t < 0
      t
    end
  end
end