class CombiwordFinder
  attr_reader :words
  attr_reader :length

  def initialize(words, length)
    @words = words
    @length = length
  end

  def combiwords
    combiword_candidates.select do |candidate|
      Entry.where(word: candidate).count > 0
    end
  end

  private

  def combiword_candidates
    (1..words.length).to_a.map do |num|
      words.combination(num).to_a.map(&:join).select do |string|
        string.length == length
      end
    end.flatten
  end
end
