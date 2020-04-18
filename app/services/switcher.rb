Switch = Struct.new(:body, :index)

class Switcher
  attr_reader :words

  def initialize(words)
    @words = words
  end

  def words_with_switches
    alternative_indices.map do |indices|
      indices.each_with_index.map do |alternative_index, word_index|
        words[word_index].alternatives[alternative_index]
      end
    end
  end

  private

  def alternative_indices
    all_arrays = [primary_array]

    for num in (0..word_count - 1)
      new_arrays = all_arrays.map { |array| generate_arrays(words[num], array) }.flatten(1)
      all_arrays += new_arrays
    end

    all_arrays.uniq
  end

  def word_count
    @word_count ||= words.count
  end

  def generate_arrays(word, array)
    (0..word.alternatives.count - 1).map { |num| array.each_with_index.map { |x, index| index == word.index ? num : x } }
  end

  def primary_array
    [0] * word_count
  end
end
