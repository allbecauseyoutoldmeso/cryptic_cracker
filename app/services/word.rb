Alternative = Struct.new(:body, :index)

class Word
  attr_reader :body
  attr_reader :index

  def initialize(body, index)
    @body = body
    @index = index
  end

  def alternatives
    @alternatives ||= ([body, initial_letter] + synonyms + abbreviations).map do |alternative_body|
      Alternative.new(alternative_body, index)
    end
  end

  def synonyms
    @synonyms ||= ThesaurusClient.new(body).synonyms
  end

  def anagram_indicator?
    entry.try(:anagram_indicator) || false
  end

  def acrostic_indicator?
    entry.try(:acrostic_indicator) || false
  end

  def abbreviations
    entry.try(:parsed_abbreviations) || []
  end

  def initial_letter
    body[0]
  end

  private

  def entry
    Entry.where(word: body).first
  end
end
