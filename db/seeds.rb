require 'csv'

def logger
  @logger ||= Logger.new('log/seeds.log')
end

def word_rows
  @word_rows ||= CSV.read('entry_data/words.csv')
end

def anagram_indicator_rows
  @anagram_indicator_rows ||= CSV.read('entry_data/anagram_indicators.csv')
end

def abbreviation_rows
  @abbreviation_rows ||= CSV.read('entry_data/abbreviations.csv')
end

def acrostic_indicator_rows
  @acrostic_indicator_row ||= CSV.read('entry_data/acrostic_indicators.csv')
end

word_rows.each do |row|
  begin
    word = row[0]
    Entry.create(word: word)
  rescue => error
    logger.info(word)
    logger.info(error.message)
  end
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

acrostic_indicator_rows.each do |row|
  begin
    word = Entry.find_by(word: row[0])
    word.update(acrostic_indicator: true)
  rescue => error
    logger.info(row[0])
    logger.info(error.message)
  end
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
