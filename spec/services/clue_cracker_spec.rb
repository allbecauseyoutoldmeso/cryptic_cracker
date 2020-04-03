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

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/listen").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'attend' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/quiet").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'noiseless' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/unusually").
            to_return(body:   { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'peculiarly' }] }] }] }] }] }.to_json, status: 200)
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

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/stingier").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'meaner' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/men").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'guys' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/are").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'live' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/drunken").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'silent' }, { 'text' => 'inebriated' }] }] }] }] }] }.to_json, status: 200)
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

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/quiet").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'noiseless' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/flier").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'bird' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/managed").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'arranged' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/steal").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'pilfer' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/to").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [] }] }] }] }] }.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['pilfer']
        end
      end
    end

    context 'combiwords' do
      context 'solution is a synonym of one word, made up of synonyms of other words' do
        let(:clue) { 'Provide support for larva.' }
        let(:length) { 11 }

        let!(:provide) { create(:entry, word: 'provide') }
        let!(:support) { create(:entry, word: 'support') }
        let!(:for) { create(:entry, word: 'for') }
        let!(:larva) { create(:entry, word: 'larva') }
        let!(:caterpillar) { create(:entry, word: 'caterpillar') }

        before do
          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/provide").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'cater' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/support").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'pillar' }] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/for").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [] }] }] }] }] }.to_json, status: 200)

          stub_request(:get, "https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/larva").
            to_return(body: { 'results' => [{ 'lexicalEntries' => [{ 'entries' => [{ 'senses' => [{ 'synonyms' => [{ 'text' => 'caterpillar' }] }] }] }] }] }.to_json, status: 200)
        end

        it 'returns solution' do
          expect(clue_cracker.solutions).to eq ['caterpillar']
        end
      end
    end
  end
end
