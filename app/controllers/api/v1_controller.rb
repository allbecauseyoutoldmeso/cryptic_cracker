module Api
  class V1Controller < ApplicationController
    before_action :authorize_request

    def definitions
      render json: DictionaryClient.new(word).definitions
    end

    def synonyms
      render json: ThesaurusClient.new(word).synonyms
    end

    def anagrams
      render json: AnagramCracker.new(characters).anagrams
    end

    def matches
      render json: PatternMatcher.new(pattern).matches
    end

    private

    def authorize_request
      unless authorized_user.present?
        render json: { error: 'unauthorized' }, status: 401
      end
    end

    def authorized_user
      User.find_by(name: username).try(:authenticate, password)
    end

    def username
      request.headers['username']
    end

    def password
      request.headers['password']
    end

    def word
      word_params[:word].downcase
    end

    def characters
      character_params[:characters].downcase.split('')
    end

    def pattern
      pattern_params[:pattern].downcase
    end

    def word_params
      params.permit(:word)
    end

    def character_params
      params.permit(:characters)
    end

    def pattern_params
      params.permit(:pattern)
    end
  end
end
