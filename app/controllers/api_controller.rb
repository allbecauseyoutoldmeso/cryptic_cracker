class ApiController < ApplicationController

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

  def word
    word_params[:word]
  end

  def letters
    letter_params[:letters].split(',')
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
