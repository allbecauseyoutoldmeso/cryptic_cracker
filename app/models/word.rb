require 'prime'

class Word < ApplicationRecord
  before_save :set_product

  private

  def set_product
    self.product = primes.inject(:*)
  end

  def primes
    letters.map { |letter| prime_map[letter] }
  end

  def letters
    written_form.split('').select { |char| char.match(/[a-z]/) }
  end

  def prime_map
    ('a'..'z').to_a.zip(Prime.take(26)).to_h
  end
end
