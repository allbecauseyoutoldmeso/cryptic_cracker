require 'prime'

class ProductCalculator
  attr_reader :characters

  def initialize(characters)
    @characters = characters
  end

  def product
    primes.inject(:*)
  end

  private

  def primes
    letters.map { |letter| prime_map[letter] }
  end

  def prime_map
    ('a'..'z').to_a.zip(Prime.take(26)).to_h
  end

  def letters
    characters.select { |character| character.match(/[a-z]/) }
  end
end
