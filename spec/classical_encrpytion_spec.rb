require 'rspec/autorun'
require_relative '../lib/classical_encryption'

def random_string(chars, size = 7 * 60)
  size.times.map{chars.sample}.join
end

def consolidate_alphabets(*ciphers)
  ciphers.inject(Set.new){|a, c| a + c.alphabet}
end

def default_args_test(cipher_class)
  describe cipher_class do
    context 'with the default arguments' do
      let(:cipher){cipher_class.new}
      it 'encrypts and decrypts a random string' do
        encrypt_test(cipher_class.new, nil)
      end
    end
  end
end

def multi_encrypt_test(ciphers)
  ciphers = ciphers.map(&:new)
  describe 'Multiple Ciphers' do
    2.upto(3) do |i|
      ciphers.combination(i) do |combo|
        context "with the ciphers #{combo.map(&:class).join(', ')}" do
          it 'encrypts and decrypts a random string' do
            encrypt_test(*combo, nil)
          end
        end
      end
    end
  end
end

def encrypt_test(cipher, *ciphers, str)
  str ||= random_string(consolidate_alphabets(cipher, *ciphers).to_a)
  expect(encrypt_and_decrypt(cipher, *ciphers, str)).to eq(str)
end

def encrypt_and_decrypt(cipher, *ciphers, str)
  ciphers.empty? ? cipher.d(cipher.e(str)) : cipher.d(encrypt_and_decrypt(*ciphers, cipher.e(str)))
end

module ClassicalEncryption

  ciphers = [
    #TrifidCipher,
    #BifidCipher,
    #PolybiusCipher,
    RailFenceCipher,
    CaesarCipher,
    OneTimePad,
    #AdfgxCipher,
    AffineCipher,
    AtbashCipher,
    #NihilistCipher,
    Rot13Cipher,
    ColumnarTranspositionCipher
  ]
  
  ciphers.each do |clazz|
    default_args_test(clazz)
  end
  
  multi_encrypt_test(ciphers)
  
  describe TrifidCipher do
    context 'with the wikipedia example arguments' do
      let(:cipher){TrifidCipher.new(5, (('felixmariedelastelle'.chars + ('a'..'z').to_a).to_set.to_a << ' '))}
      it 'tests the wikipedia example' do
        expect(cipher.e('aidetoilecieltaidera')).to eq('fmjfvoissuftfpufeqqc')
      end
    end
    context 'with custom arguments' do
      1.upto(20) do |i|
        it "tests with a group size of #{i}" do
          #encrypt_test(TrifidCipher.new(i), nil)
        end
      end
    end
  end
end