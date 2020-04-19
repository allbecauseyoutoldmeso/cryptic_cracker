require 'prime'

class Entry < ApplicationRecord
  before_save :set_product
  validates :word, presence: true, format: { with: /\A[a-z]*\z/ }

  def parsed_abbreviations
    abbreviations.try(:split, '') || []
  end

  private

  def set_product
    self.product = product_calculator.product.to_s
  end

  def product_calculator
    ProductCalculator.new(characters)
  end

  def characters
    word.split('')
  end
end
