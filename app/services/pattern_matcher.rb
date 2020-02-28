class PatternMatcher

  attr_reader :pattern

  def initialize(pattern)
    @pattern = pattern
  end

  def words
    Word.where('written_form REGEXP ?', regex).map(&:written_form)
  end

  private

  def regex
    "^#{pattern.gsub(/[^abc]/, '.')}$"
  end
end
