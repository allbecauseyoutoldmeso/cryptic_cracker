require 'rails_helper'

RSpec.describe ClueCracker do

  describe 'solutions' do
    let(:clue_cracker) { ClueCracker.new(clue, length) }

    context 'anagrams' do
      context 'solution is an anagram of one word and a synonym of another' do
        let(:clue) { 'Listen, unusually quiet.' }
        let(:length) { 6 }

        let!(:silent) { create(:word, written_form: 'silent') }
        let!(:tinsel) { create(:word, written_form: 'tinsel') }
        let!(:unusually) { create(:word, written_form: 'unusually', anagram_indicator: true)}


        let(:response_one) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'attend' }] }] }] }] }] }
        end

        let(:response_two) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'noiseless' }] }] }] }] }] }
        end

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/listen").
            to_return(body: response_one.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/quiet").
            to_return(body: response_two.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['silent']
        end
      end
    end
  end
end
