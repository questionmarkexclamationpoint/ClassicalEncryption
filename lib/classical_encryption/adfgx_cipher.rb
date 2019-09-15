module ClassicalEncryption
  class AdfgxCipher < ExtendedPolybiusCipher
    @@ADFGX = 'ADFGX'.chars
    @@ADFGX_HASH = Hash[@@ADFGX.collect.with_index{|c, i| [c, i]}]
    def initialize(alphabet = 'btalpdhozkqfvsngicuxmrewy'.chars, key = 'adfgx')
      super(alphabet)
      @key = filter(key.chars.map{|c| c == 'j' || c == 'J' ? 'i' : c}.join('')).chars.map.with_index{|c, i| "#{c}#{i}"}
      @key_hash = Hash[@key.collect.with_index{|c, i| [c, i]}]
      @sorted_key = @key.sort
    end
    def encrypt(plaintext)
      text = super(filter(plaintext.chars.map{|c| c == 'j' ? 'i' : c}.join('')))
        .chars
        .map{|c| @@ADFGX[(c.to_i - 1) % @@ADFGX.length]}
        .join
      h = @key.map{[]}
      text.each_char.with_index do |c, i|
        h[i % @key.length] << c
      end
      h.sort_by.with_index{|a, i| @key[i]}.map{|c| c.join}.join(' ')
    end
    def decrypt(ciphertext)
      super(ciphertext
        .split
        .map{|c| (c + (' ' * (@key.length - c.length))).chars}
        .sort_by
        .with_index{|c, i| @key_hash[@sorted_key[i]]}
        .transpose
        .flatten
        .reject{|c| c == ' '}
        .map{|c| (@@ADFGX_HASH[c] + 1).to_s}
        .join
      )
    end
  end
end