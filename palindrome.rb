require 'test/unit'

def palindrome?(string)
  string = string.gsub(/\W/,'').downcase
  return string == string.reverse
end

def count_words(string)
  map = {}
  string.downcase.gsub(/[^\w\s]/, '').gsub(/[\s]+/, ' ').split(/\b/).each do |m|
    unless (m =~ /\s+/)
      if (!map.key? m)
      map[m] = 0
      end
    map[m] = map[m] + 1
    end
  end
  return map
end

class String
  def palindrome?
    string = self
    string = string.gsub(/\W/,'').downcase
    return string == string.reverse
  end
end

module Enumerable
  def palindrome?
    reversed = []
    self.reverse_each { |e| reversed += [e] }
    self == reversed
  end
end

class TestPalindromes < Test::Unit::TestCase
  def test_palindrome
    assert('A man, a plan, a canal -- Panama'.palindrome?)
    assert(!'lalaa'.palindrome?)
    assert([1,2,3,2,1].palindrome?)
    assert(![1,2,3,4,1].palindrome?)
  end

end

puts count_words ('A man, a plan, a canal -- Panama')

puts count_words 'Doo bee doo bee doo'