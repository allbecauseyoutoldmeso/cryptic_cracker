require 'prime'

class AnagramCracker
  attr_reader :letters

  def initialize(letters)
    @letters = letters
  end

  def words
    Word.where(product: product).map(&:written_form)
  end

  private

  def product
    primes.inject(:*)
  end

  def primes
    letters.map { |letter| prime_map[letter] }
  end

  def prime_map
    ('a'..'z').to_a.zip(Prime.take(26)).to_h
  end
end
