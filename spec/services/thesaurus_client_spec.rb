require 'rails_helper'

RSpec.describe ThesaurusClient do

  describe 'synonyms' do
    let(:word) { 'rat' }
    let(:synonym_one) { 'scoundrel' }
    let(:synonym_two) { 'informer' }

    let(:synonyms) do
      [{ 'text' => synonym_one }, { 'text' => synonym_two}]
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

    let(:status) { 200 }

    before do
      stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/#{word}").
        to_return(body: response_body.to_json, status: status)
    end

    it 'returns all synonyms of the word' do
      expect(ThesaurusClient.new(word).synonyms).to eq [synonym_one, synonym_two]
    end
  end
end
