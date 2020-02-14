require 'csv'
require 'prime'

def logger
  @logger ||= Logger.new('log/seeds.log')
end

def prime_map
  ('a'..'z').to_a.zip(Prime.take(26)).to_h
end

def letters(word)
  word.split('').select { |char| char.match(/[a-z]/) }
end

def primes(letters)
  letters.map { |letter| prime_map[letter] }
end

def product(word)
  letters = letters(word)
  primes = primes(letters)
  primes.inject(:*)
end

def rows
  @rows ||= CSV.read('words.csv')
end

rows.each do |row|
  begin
    word = row[0].downcase
    product = product(word)
    Word.create(written_form: word, product: product.to_s)
  rescue => error
    logger.info(word)
    logger.info(error.message)
  end
end
