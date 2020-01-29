require 'rest_client'

class ThesaurusClient
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def synonyms
    parsed_response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'].map do |sense|
      sense['synonyms'].map do |synonym|
        synonym['text']
      end
    end.flatten
  end

  private

  def parsed_response
    JSON.parse(response)
  end

  def response
    RestClient.get(url, headers)
  end

  def url
    base_url + word
  end

  def headers
    {
      'app_id' => ENV['OXFORD_DICTIONARY_APP_ID'],
      'app_key' => ENV['OXFORD_DICTIONARY_APP_KEY']
    }
  end

  def base_url
    'https://od-api.oxforddictionaries.com/api/v2/thesaurus/en-gb/'
  end
end
