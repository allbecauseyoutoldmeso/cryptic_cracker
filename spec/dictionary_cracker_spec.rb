require 'rails_helper'

RSpec.describe DictionaryClient do

  describe 'definitions' do
    let(:word) { 'rat' }
    let(:definition_one) { 'a rodent that resembles a large mouse' }
    let(:definition_two) { 'a despicable person' }

    let(:senses) do
      [ { 'definitions' => [definition_one] },  {'definitions' => [definition_two] } ]
    end

    let(:entries) do
      [{ 'senses' => senses }]
    end

    let(:response_body) do
      { 'results' => [{ 'lexicalEntries' => [{ 'entries' => entries }] }] }
    end

    let(:status) { 200 }

    before do
      stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/entries/en-gb/#{word}?fields=definitions").
        to_return(body: response_body.to_json, status: status)
    end

    it 'returns definitions' do
      expect(DictionaryClient.new(word).definitions).to eq [definition_one, definition_two]
    end

    context 'no definition exists' do
      let(:word) { 'tra' }

      let(:response_body) do
        { 'error' => 'No entry found matching supplied source_lang, word and provided filters' }
      end

      let(:status) { 404 }

      it 'returns empty array' do
        expect(DictionaryClient.new(word).definitions).to eq []
      end
    end
  end
end
