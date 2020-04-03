require 'rails_helper'

RSpec.describe ClueCracker do

  describe 'solutions' do
    let(:clue_cracker) { ClueCracker.new(clue, length) }

    context 'anagrams' do
      context 'solution is a synonym of one word and an anagram of another' do
        let(:clue) { 'Listen, unusually quiet.' }
        let(:length) { 6 }

        let!(:silent) { create(:entry, word: 'silent') }
        let!(:quiet) { create(:entry, word: 'quiet') }
        let!(:quiet) { create(:entry, word: 'listen') }
        let!(:unusually) { create(:entry, word: 'unusually', anagram_indicator: true)}

        let(:response_one) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'attend' }] }] }] }] }] }
        end

        let(:response_two) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'noiseless' }] }] }] }] }] }
        end

        let(:response_three) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'peculiarly' }] }] }] }] }] }
        end

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/listen").
            to_return(body: response_one.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/quiet").
            to_return(body: response_two.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/unusually").
            to_return(body: response_three.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['silent']
        end
      end

      context 'solution is a synonym of one word and an anagram of several others' do
        let(:clue) { 'Drunken men are stingier.' }
        let(:length) { 6 }

        let!(:meaner) { create(:entry, word: 'meaner') }
        let!(:men) { create(:entry, word: 'men') }
        let!(:are) { create(:entry, word: 'are') }
        let!(:drunken) { create(:entry, word: 'drunken', anagram_indicator: true)}

        let(:response_one) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'meaner' }] }] }] }] }] }
        end

        let(:response_two) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'guys' }] }] }] }] }] }
        end

        let(:response_three) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'live' }] }] }] }] }] }
        end

        let(:response_four) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'inebriated' }] }] }] }] }] }
        end

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/stingier").
            to_return(body: response_one.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/men").
            to_return(body: response_two.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/are").
            to_return(body: response_three.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/drunken").
            to_return(body: response_four.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['meaner']
        end
      end

      context 'solution is a synonym of one word and an anagram of words and abbreviatons' do
        let(:clue) { 'Quiet flier managed to steal.' }
        let(:length) { 6 }

        let!(:quiet) { create(:entry, word: 'quiet', abbreviations: 'p') }
        let!(:flier) { create(:entry, word: 'flier') }
        let!(:managed) { create(:entry, word: 'managed', anagram_indicator: true) }
        let!(:to) { create(:entry, word: 'to')}
        let!(:steal) { create(:entry, word: 'steal') }
        let!(:pilfer) { create(:entry, word: 'pilfer') }

        let(:response_one) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'noiseless' }] }] }] }] }] }
        end

        let(:response_two) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'bird' }] }] }] }] }] }
        end

        let(:response_three) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'arranged' }] }] }] }] }] }
        end

        let(:response_four) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'pilfer' }] }] }] }] }] }
        end

        let(:response_five) do
          { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [] }] }] }] }] }
        end

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/quiet").
            to_return(body: response_one.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/flier").
            to_return(body: response_two.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/managed").
            to_return(body: response_three.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/steal").
            to_return(body: response_four.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/to").
            to_return(body: response_five.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['pilfer']
        end
      end
    end
  end
end
