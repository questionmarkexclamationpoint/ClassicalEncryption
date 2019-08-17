class Cipher
  def initialize(alphabet = ('a'..'z').to_a << ' ')
    @upcase = ('a'..'z').none?{|a| alphabet.include?(a)}
    @downcase = ('A'..'Z').none?{|a| alphabet.include?(a)}
    @alphabet = construct_alphabet(alphabet)
    @alphabet_hash = construct_alphabet_hash(@alphabet)
  end
  def encrypt(plaintext)
    raise NotImplementedError
  end
  def decrypt(ciphertext)
    raise NotImplementedError
  end
  def e(p)
    encrypt(p)
  end
  def d(e)
    decrypt(e)
  end
  def encipher(p)
    encrypt(p)
  end
  def decipher(e)
    decrypt(e)
  end
  def self.decipher(p)
    new.encipher(p)
  end
  def self.encipher(e)
    new.encipher(e)
  end
  def self.encrypt(p)
    new.encrypt(p)
  end
  def self.decrypt(e)
    new.d(e)
  end
  def self.e(p)
    new.e(p)
  end
  def self.d(e)
    new.d(e)
  end
  def self.keyword_alphabet(key, alphabet = ('a'..'z').to_a)
    (key.chars + alphabet).uniq
  end
  
  protected
  
  def self.coprime?(a, b)
    return false if (a | b) & 1 == 0
    a >>= 1 while a & 1 == 0
    return true if a == 1
    while b != 0 do
      b >>= 1 while b & 1 == 0
      return true if b == 1
      a, b = b, a if a > b
      b -= a
    end
    false
  end
  def construct_alphabet(alphabet)
    alphabet.map{|a| @upcase ? a.upcase : (@downcase ? a.downcase : a)}.uniq
  end
  def construct_alphabet_hash(alphabet)
    Hash[alphabet.collect.with_index{|c, i| [c, i]}]
  end
  def filter(s)
    (@upcase ? s.upcase : (@downcase ? s.downcase : s)).chars.select{|c| @alphabet.flatten.include?(c)}.join('')
  end
end
