class Word
  attr_reader :body
  attr_reader :index

  def initialize(body, index)
    @body = body
    @index = index
  end

  def alternatives
    synonyms + abbreviations + [initial_letter]
  end

  def synonyms
    @synonyms ||= ThesaurusClient.new(body).synonyms
  end

  def abbreviations
    entry.try(:parsed_abbreviations) || []
  end

  def initial_letter
    body[0]
  end

  private

  def entry
    Entry.where(word: body)[0]
  end
end
