class OneTimePad < Cipher
  def initialize(key = 'onetimepad', alphabet = ('a'..'z').to_a << ' ')
    super(alphabet)
    @key = filter(key).chars
  end
  def encrypt(plaintext)
    filter(plaintext)
      .chars
      .map
      .with_index{|c, i| @alphabet[(@alphabet_hash[c] + @alphabet_hash[@key[i % @key.length]]) % @alphabet.length]}
      .join('')
  end
  def decrypt(ciphertext)
    ciphertext
      .chars
      .map
      .with_index{|c, i| @alphabet[(@alphabet_hash[c] - @alphabet_hash[@key[i % @key.length]]) % @alphabet.length]}
      .join('')
  end
end
