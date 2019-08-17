class ExtendedPolybiusCipher < Cipher
  def initialize(alphabet = ('a'..'z').to_a - ['j'])
    @square_size = square_size(alphabet)
    super
  end
  def encrypt(plaintext)
    filter(plaintext)
      .chars
      .map{|c| @alphabet_hash[c].map{|i| i + 1}}
      .flatten
      .join
  end
  def decrypt(ciphertext)
    raise ArgumentError if ciphertext.length % 2 == 1
    ciphertext
      .chars
      .each_slice(2)
      .map{|s| @alphabet[s[0].to_i - 1][s[1].to_i - 1]}
      .join
  end
  
  protected
  
  def construct_alphabet(alphabet)
    alphabet = Cipher.instance_method(:construct_alphabet).bind(self).call(alphabet)
    a = []
    @square_size.times do |i|
      a << []
      @square_size.times do |j|
        break if i * @square_size + j >= alphabet.length
        a[i] << alphabet[i * @square_size + j]
      end
    end
    a
  end
  def construct_alphabet_hash(alphabet)
    a = alphabet.flatten
    h = Cipher.instance_method(:construct_alphabet_hash).bind(self).call(a)
    Hash[a.collect.with_index{|c, i| [c, [h[c] / @square_size, h[c] % @square_size]]}]
  end
  def square_size(alphabet)
    Math.sqrt(alphabet.length).ceil
  end
end
