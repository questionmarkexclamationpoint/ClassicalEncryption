class BifidCipher < ExtendedPolybiusCipher
  def initialize(alphabet = ('a'..'z').to_a - ['j'])
    super
    raise ArgmentError if alphabet.length != @square_size ** 2
  end
  def encrypt(plaintext)
    e = super
    s = ''
    (e.length / 2).times do |i|
      s << e[i * 2]
    end
    (e.length / 2).times do |i|
      s << e[i * 2 + 1]
    end
    puts e
    puts s
    ExtendedPolybiusCipher.instance_method(:decrypt).bind(self).call(s)
  end
  def decrypt(ciphertext)
    s = ExtendedPolybiusCipher.instance_method(:encrypt).bind(self).call(ciphertext)
    puts s
    puts s.length
    d = ''
    (s.length / 2).times do |i|
      d << s[i] << s[i + s.length / 2]
    end
    puts d
    super(d)
  end
end
