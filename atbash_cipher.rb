class AtbashCipher < Cipher
  def encrypt(plaintext)
    filter(plaintext)
      .chars
      .map{|c| @alphabet.reverse[@alphabet_hash[c]]}
      .join
  end
  def decrypt(ciphertext)
    encrypt(ciphertext)
  end
end
