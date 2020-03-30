require 'csv'

def logger
  @logger ||= Logger.new('log/seeds.log')
end

def word_rows
  @word_rows ||= CSV.read('words.csv')
end

word_rows.each do |row|
  begin
    word = row[0].downcase
    Entry.create(word: word)
  rescue => error
    logger.info(word)
    logger.info(error.message)
  end
end

def anagram_indicator_rows
  @anagram_indicator_rows ||= CSV.read('anagram_indicators.csv')
end

anagram_indicator_rows.each do |row|
  begin
    word = Entry.find_by(word: row[0])
    word.update(anagram_indicator: true)
  rescue => error
    logger.info(row[0])
    logger.info(error.message)
  end
end

def abbreviation_rows
  @abbreviation_rows ||= CSV.read('abbreviations.csv')
end

abbreviation_rows.each do |row|
  begin
    word = Entry.find_by(word: row[0])
    word.update(abbreviations: row[1..-1].join(','))
  rescue => error
    logger.info(row[0])
    logger.info(error.message)
  end
end
