require 'prime'

class Word < ApplicationRecord
  before_save :set_product

  private

  def set_product
    self.product = product_calculator.product.to_s
  end

  def product_calculator
    ProductCalculator.new(characters)
  end

  def characters
    written_form.split('')
  end
end
