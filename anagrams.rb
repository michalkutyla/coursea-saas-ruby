require "test/unit"

def combine_anagrams(words)
  classes = []
  words.each do |w|
    class_index = classes.index {|v| v.first != nil && normalize(v.first) == normalize(w)}
    if (class_index == nil)
      classes.insert( -1, [w])
    else
    classes[class_index].insert( -1, w)
    end
  end
  return classes
end

def normalize(word)
  if (word == nil) ; return nil ; end
  return word.downcase.chars.sort.join
end

class TestAnagrams < Test::Unit::TestCase
  def test_complex
    input = ['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream']
    expected_output = [["cars", "racs", "scar"], ["for"], ["potatoes"], ["four"], ["creams", "scream"]]
    assert_equal(expected_output, combine_anagrams(input))
  end
end
