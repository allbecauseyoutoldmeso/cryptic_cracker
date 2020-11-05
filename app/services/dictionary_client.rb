require 'rest-client'

class DictionaryClient
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def definitions
    if parsed_response['error'].present?
      []
    else
      parsed_response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'].map do |sense|
        sense['definitions'][0]
      end
    end
  end

  private

  def parsed_response
    JSON.parse(response)
  end

  def response
    begin
      RestClient.get(url, headers)
    rescue RestClient::NotFound => error
      error.response
    end
  end

  def url
    base_url + word + '?' + filters.to_param
  end

  def filters
    { fields: 'definitions' }
  end

  def headers
    {
      'app_id' => ENV['OXFORD_DICTIONARY_APP_ID'],
      'app_key' => ENV['OXFORD_DICTIONARY_APP_KEY']
    }
  end

  def base_url
    'https://od-api.oxforddictionaries.com/api/v2/entries/en-gb/'
  end
end
