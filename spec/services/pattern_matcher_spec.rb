require 'rails_helper'

RSpec.describe PatternMatcher do

  describe 'words' do
    let(:pattern) { 'b-n-n-' }

    let!(:banana) { create(:entry, word: 'banana') }
    let!(:bananas) { create(:entry, word: 'bananas') }
    let!(:ban) { create(:entry, word: 'bananas') }

    let(:pattern_matcher) { PatternMatcher.new(pattern) }

    it 'returns possible solutions' do
      expect(pattern_matcher.matches).to eq [banana.word]
    end
  end
end
