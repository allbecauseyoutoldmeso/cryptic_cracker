class PatternMatcher

  attr_reader :characters

  def initialize(pattern)
    @characters = pattern.split('')
  end

  def words
    Word.where('written_form REGEXP ?', regex).map(&:written_form)
  end

  private

  def regex
    string = ''
    count = 0

    characters.each_with_index do |character, index|
      if character.match(/[a-z]/)
        string += ('.{' + count.to_s + '}[' + character + ']')
        count = 0
      else
        count += 1
        if index === (characters.count - 1)
          string += ('.{' + count.to_s + '}')
        end
      end
    end

    '\A' + string + '\z'
  end
end
