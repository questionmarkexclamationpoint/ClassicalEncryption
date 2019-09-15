require 'rspec/autorun'
require_relative '../lib/classical_encryption'

def random_string(chars)
  50.times.map{chars.sample}.join
end

def encrypt_test(cipher_class)
  let(:cipher){cipher_class.new}
  it 'encrypts a random string' do
    str = random_string(cipher.alphabet.to_a)
    expect(cipher.d(cipher.e(str))).to eq(str)
  end
end

describe ClassicalEncryption::TrifidCipher do
  encrypt_test(ClassicalEncryption::TrifidCipher)
end

describe ClassicalEncryption::OneTimePad do
  encrypt_test(ClassicalEncryption::OneTimePad)
end

describe ClassicalEncryption::AffineCipher do
  encrypt_test(ClassicalEncryption::AffineCipher)
end

describe ClassicalEncryption::AdfgxCipher do
  encrypt_test(ClassicalEncryption::AdfgxCipher)
end

describe ClassicalEncryption::BifidCipher do
  encrypt_test(ClassicalEncryption::BifidCipher)
end

describe ClassicalEncryption::NihilistCipher do
  encrypt_test(ClassicalEncryption::NihilistCipher)
end

describe ClassicalEncryption::AtbashCipher do
  encrypt_test(ClassicalEncryption::AtbashCipher)
end

describe ClassicalEncryption::CaesarCipher do
  encrypt_test(ClassicalEncryption::CaesarCipher)
end

describe ClassicalEncryption::Rot13Cipher do
  encrypt_test(ClassicalEncryption::Rot13Cipher)
end

describe ClassicalEncryption::PolybiusCipher do
  encrypt_test(ClassicalEncryption::PolybiusCipher)
end

describe ClassicalEncryption::RailFenceCipher do
  encrypt_test(ClassicalEncryption::RailFenceCipher)
end