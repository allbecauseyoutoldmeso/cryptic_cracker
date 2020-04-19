require 'rails_helper'

RSpec.describe Entry do

  it 'sets product on save' do
    word = Entry.create(word: 'cupcake')
    expect(word.product).to eq '65966450'
  end

  it 'is invalid if word contains non-alphabetical characters' do
    word = Entry.new(word: 'cup-cake')
    expect(word.valid?).to eq false
  end
end
