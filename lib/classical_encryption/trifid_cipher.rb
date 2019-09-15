module ClassicalEncryption
  class TrifidCipher < ExtendedPolybiusCipher
    def initialize(group_size = 5, alphabet = ('a'..'z').to_a << ' ')
      super(alphabet)
      raise ArgumentError if alphabet.length != @square_size ** 3
      @group_size = group_size
      warn 'Group size should be coprime with three for maximum diffusion.' if !Cipher.coprime?(@group_size, 3)
    end
    def encrypt(plaintext)
      filter(plaintext)
        .chars
        .map{|c| @alphabet_hash[c]}
        .flatten
        .each_slice(@group_size * 3)
        .map{|s| s.each_slice(3).to_a.transpose}
        .flatten
        .each_slice(3)
        .map{|s| @alphabet[s[0]][s[1]][s[2]]}
        .join
    end
    def decrypt(ciphertext)
      ciphertext.chars
        .map{|c| @alphabet_hash[c]}
        .flatten
        .each_slice(@group_size * 3)
        .map{|s| s.each_slice(@group_size).to_a.transpose}
        .flatten
        .each_slice(3)
        .map{|s| @alphabet[s[0]][s[1]][s[2]]}
        .join
    end
    
    protected
    
    def square_size(alphabet)
      (alphabet.length ** (1 / 3.0)).ceil
    end
    def construct_alphabet(alphabet)
      a = []
      @square_size.times do |i|
        a << []
        @square_size.times do |j|
          a[i] << []
          @square_size.times do |k|
            a[i][j] << alphabet[i * @square_size * @square_size + j * @square_size + k]
          end
        end
      end
      a
    end
    def construct_alphabet_hash(alphabet)
      a = alphabet.flatten
      h = Cipher.instance_method(:construct_alphabet_hash).bind(self).call(a)
      Hash[
        a.collect.with_index do |c, i|
          n1 = h[c] / @square_size ** 2
          n2 = (h[c] % @square_size ** 2) / @square_size
          n3 = (h[c] % @square_size)
          [c, [n1, n2, n3]]
        end
      ]
    end
  end
end