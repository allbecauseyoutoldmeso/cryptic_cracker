class Word
  attr_reader :body
  attr_reader :index

  def initialize(body, index)
    @body = body
    @index = index
  end

  def synonyms
    @synonyms ||= ThesaurusClient.new(body).synonyms
  end

  def abbreviations
    entry.try(:abbreviations).try(:split, ',') || []
  end

  private

  def entry
    Entry.where(word: body)[0]
  end
end
