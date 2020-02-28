require 'csv'
require 'prime'

def logger
  @logger ||= Logger.new('log/seeds.log')
end

def rows
  @rows ||= CSV.read('words.csv')
end

rows.each do |row|
  begin
    word = row[0].downcase
    Word.create(written_form: word)
  rescue => error
    logger.info(word)
    logger.info(error.message)
  end
end
