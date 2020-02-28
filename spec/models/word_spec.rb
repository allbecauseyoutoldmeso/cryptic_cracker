require 'rails_helper'

RSpec.describe Word do

  it 'sets product on save' do
    word = Word.create(written_form: 'cupcake')
    expect(word.product).to eq '65966450'
  end

  it 'work with non-alphabetical characters' do
    word = Word.create(written_form: 'cup-cake')
    expect(word.product).to eq '65966450'
  end
end
