require 'rails_helper'

RSpec.describe ApiController, type: :request do

  let(:password) { 'password' }
  let(:username) { 'username' }
  let!(:user) { create(:user, name: username, password: password) }

  let(:headers) do
    {
      username: username,
      password: password
    }
  end

  describe 'definitions' do
    let(:word) { 'unicorn' }
    let(:definition_one) { 'a magical animal' }
    let(:definition_two) { 'something rare' }

    let(:response_body) do
      { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'definitions' => [definition_one] },  {'definitions' => [definition_two] }] }] }] }] }
    end

    let(:params) do
      { word: word }
    end

    it 'returns definitions' do
      stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/entries/en-gb/#{word}?fields=definitions").
        to_return(body: response_body.to_json, status: 200)

      get '/api/definitions', params: params, headers: headers
      expect(JSON.parse(response.body)).to contain_exactly(definition_one, definition_two)
    end

    describe 'unauthorised request' do
      let(:headers) do
        {
          username: username,
          password: 'wrong_password'
        }
      end

      it 'returns 401' do
        get '/api/definitions', params: params, headers: headers
        expect(response.status).to eq 401
      end
    end
  end

  describe 'synonyms' do
    let(:word) { 'magic' }
    let(:synonym_one) { 'illusion' }
    let(:synonym_two) { 'wizardry' }

    let(:response_body) do
      { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => synonym_one }, { 'text' => synonym_two}] }] }] }] }] }
    end

    let(:params) do
      { word: word }
    end

    it 'returns synonyms' do
      stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/#{word}").
        to_return(body: response_body.to_json, status: 200)

      get '/api/synonyms', params: params, headers: headers
      expect(JSON.parse(response.body)).to contain_exactly(synonym_one, synonym_two)
    end
  end

  describe 'anagrams' do
    let(:letters) { 'tinsel'}
    let!(:anagram_one) { create(:word, written_form: 'silent') }
    let!(:anagram_two) { create(:word, written_form: 'listen') }

    let(:params) do
      { letters: letters}
    end

    it 'returns anagrams' do
      get '/api/anagrams/', params: params, headers: headers
      expect(JSON.parse(response.body)).to contain_exactly(anagram_one.written_form, anagram_two.written_form)
    end
  end

  describe 'matches' do
    let(:pattern) { 'f_o_e_'}
    let!(:match_one) { create(:word, written_form: 'flower') }
    let!(:match_two) { create(:word, written_form: 'fooled') }

    let(:params) do
      { pattern: pattern }
    end

    it 'returns matches' do
      get '/api/matches', params: params, headers: headers
      expect(JSON.parse(response.body)).to contain_exactly(match_one.written_form, match_two.written_form)
    end
  end
end
