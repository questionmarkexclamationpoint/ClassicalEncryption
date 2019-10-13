module ClassicalEncryption
  class AtbashCipher < Cipher
    def initialize(alphabet = ('a'..'z').to_a << ' ')
      super
      @reverse_alphabet = @alphabet.reverse
    end
    def encrypt(plaintext)
      filter(plaintext)
        .chars
        .map{|c| @reverse_alphabet[@alphabet_hash[c]]}
        .join
    end
    def decrypt(ciphertext)
      encrypt(ciphertext)
    end
  end
end