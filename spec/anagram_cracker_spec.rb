require 'rails_helper'

RSpec.describe AnagramCracker do

  describe 'words' do
    let(:letters) { ['r', 'a', 't'] }
    let(:anagram_cracker) { AnagramCracker.new(letters) }

    before do
      allow(anagram_cracker).to receive(:has_definition?).and_return(false)
      allow(anagram_cracker).to receive(:has_definition?).with('rat').and_return(true)
      allow(anagram_cracker).to receive(:has_definition?).with('art').and_return(true)
      allow(anagram_cracker).to receive(:has_definition?).with('tar').and_return(true)
    end

    it 'returns all possible solutions' do
      expect(anagram_cracker.words).to eq ['rat', 'art', 'tar']
    end
  end
end
