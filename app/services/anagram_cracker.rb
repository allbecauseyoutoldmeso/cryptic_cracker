class AnagramCracker
  attr_reader :characters

  def initialize(characters)
    @characters = characters
  end

  def anagrams
    Entry.where(product: product).map(&:word)
  end

  private

  def product
    ProductCalculator.new(characters).product
  end
end
