require 'rails_helper'

RSpec.describe PatternMatcher do

  describe 'words' do
    let(:pattern) { 'b-n-n-' }
    let!(:banana) { create(:word, written_form: 'banana') }
    let(:anagram_cracker) { PatternMatcher.new(pattern) }

    it 'returns possible solutions' do
      expect(anagram_cracker.words).to eq ['banana']
    end
  end
end
