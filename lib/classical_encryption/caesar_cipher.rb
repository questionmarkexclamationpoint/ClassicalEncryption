module ClassicalEncryption
  class CaesarCipher < AffineCipher
    def initialize(offset = 1, alphabet = ('a'..'z').to_a << ' ')
      super(1, offset, alphabet)
    end
  end
end