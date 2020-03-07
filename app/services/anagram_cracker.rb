class AnagramCracker
  attr_reader :characters

  def initialize(characters)
    @characters = characters
  end

  def anagrams
    Word.where(product: product).map(&:written_form)
  end

  private

  def product
    ProductCalculator.new(characters).product
  end
end
