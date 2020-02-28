require 'rails_helper'

RSpec.describe AnagramCracker do

  describe 'words' do
    let(:letters) { ['r', 'a', 't'] }

    let!(:rat) { create(:word, written_form: 'rat', product: 8662) }
    let!(:art) { create(:word, written_form: 'art', product: 8662) }
    let!(:tar) { create(:word, written_form: 'tar', product: 8662) }
    let!(:rate) { create(:word, written_form: 'rate', product: 95282) }

    let(:anagram_cracker) { AnagramCracker.new(letters) }

    it 'returns all possible solutions' do
      expect(anagram_cracker.words).to eq ['rat', 'art', 'tar']
    end
  end
end
