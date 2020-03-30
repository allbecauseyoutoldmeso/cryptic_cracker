require 'rails_helper'

RSpec.describe AnagramCracker do

  describe 'words' do
    let(:characters) { ['r', 'a', 't'] }

    let!(:rat) { create(:entry, word: 'rat', product: 8662) }
    let!(:art) { create(:entry, word: 'art', product: 8662) }
    let!(:tar) { create(:entry, word: 'tar', product: 8662) }
    let!(:rate) { create(:entry, word: 'rate', product: 95282) }

    let(:anagram_cracker) { AnagramCracker.new(characters) }

    it 'returns all possible solutions' do
      expect(anagram_cracker.anagrams).to eq ['rat', 'art', 'tar']
    end
  end
end
