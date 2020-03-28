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
    Word.create(written_form: word)
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
    word = Word.find_by(written_form: row[0])
    word.try(:update, { anagram_indicator: true })
  rescue => error
    logger.info(row[0])
    logger.info(error.message)
  end
end
