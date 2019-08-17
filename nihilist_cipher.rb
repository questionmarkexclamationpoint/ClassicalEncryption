class NihilistCipher < ExtendedPolybiusCipher
  def initialize(key = 'nihilist', alphabet = ('a'..'z').to_a + ' ')
    super(alphabet)
    @key = filter(key)
  end
  def encrypt(plaintext)
    super
      .chars
      .each_slice(2)
      .map
      .with_index do |s, i|
        k = @alphabet_hash[@key[i % @key.length]].map{|i| i + 1}
        (s[0].to_i + k[0]) * 10 + s[1].to_i + k[1]
      end
      .join(' ')
  end
  def decrypt(ciphertext)
  
  end
end
