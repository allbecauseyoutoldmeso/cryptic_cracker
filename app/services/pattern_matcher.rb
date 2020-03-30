class PatternMatcher

  attr_reader :pattern

  def initialize(pattern)
    @pattern = pattern
  end

  def matches
    Entry.where('word REGEXP ?', regex).map(&:word)
  end

  private

  def regex
    "^#{pattern.gsub(/[^a-z]/, '.')}$"
  end
end
