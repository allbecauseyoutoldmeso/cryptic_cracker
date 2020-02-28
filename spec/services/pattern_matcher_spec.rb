require 'rails_helper'

RSpec.describe PatternMatcher do

  describe 'words' do
    let(:pattern) { 'b-n-n-' }

    let!(:banana) { create(:word, written_form: 'banana') }
    let!(:bananas) { create(:word, written_form: 'bananas') }
    let!(:ban) { create(:word, written_form: 'bananas') }

    let(:anagram_cracker) { PatternMatcher.new(pattern) }

    it 'returns possible solutions' do
      expect(anagram_cracker.words).to eq [banana.written_form]
    end
  end
end
