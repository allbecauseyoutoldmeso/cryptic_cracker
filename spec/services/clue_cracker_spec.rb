require 'rails_helper'

RSpec.describe ClueCracker do

  describe 'solutions' do
    let(:clue_cracker) { ClueCracker.new(word.written_form, length) }

    let(:synonyms) do
      [{ 'text' => word.written_form }]
    end

    let(:senses) do
      [{ 'synonyms' => synonyms }]
    end

    let(:entries) do
      [{ 'senses' => senses }]
    end

    let(:response_body) do
      { 'results' => [{ 'lexicalEntries' => [{ 'entries' => entries }] }] }
    end

    before do
      stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/#{word.written_form}").
        to_return(body: response_body.to_json, status: 200)
    end

    context 'anagrams' do
      context 'solution is an anagram of one word and a synonym of another' do
        let(:clue) { 'Listen, mutinously quiet.' }
        let!(:word) { create(:word, written_form: 'silent') }
        let(:length) { 6 }

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['silent']
        end
      end
    end
  end
end
