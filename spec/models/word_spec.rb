require 'rails_helper'

RSpec.describe Entry do

  it 'sets product on save' do
    word = Entry.create(word: 'cupcake')
    expect(word.product).to eq '65966450'
  end

  it 'work with non-alphabetical characters' do
    word = Entry.create(word: 'cup-cake')
    expect(word.product).to eq '65966450'
  end
end
