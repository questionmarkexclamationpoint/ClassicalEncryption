module ClassicalEncryption
  class PolybiusCipher < ExtendedPolybiusCipher
    def initialize
      super(('a'..'z').to_a - ['j'])
    end
    def encrypt(plaintext)
      super(plaintext.chars.map{|c| c == 'j' || c == 'J' ? 'i' : c}.join(''))
    end
  end
end