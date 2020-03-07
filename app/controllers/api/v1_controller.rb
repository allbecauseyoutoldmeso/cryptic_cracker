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
      render json: AnagramCracker.new(letters).words
    end

    def matches
      render json: PatternMatcher.new(pattern).words
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
      word_params[:word]
    end

    def letters
      letter_params[:letters].split('')
    end

    def pattern
      pattern_params[:pattern]
    end

    def word_params
      params.permit(:word)
    end

    def letter_params
      params.permit(:letters)
    end

    def pattern_params
      params.permit(:pattern)
    end
  end
end
