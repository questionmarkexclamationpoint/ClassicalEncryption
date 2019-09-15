module ClassicalEncryption
  class Rot13Cipher < CaesarCipher
    def initialize(alphabet = ('a'..'z').to_a << ' ')
      super(13, alphabet)
    end
  end
end