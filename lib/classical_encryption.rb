module ClassicalEncryption
  require 'set'
  require_relative 'classical_encryption/cipher'
  require_relative 'classical_encryption/extended_polybius_cipher'
  Dir["#{File.dirname(__FILE__)}/classical_encryption/*.rb"].each{|file| require file}
end