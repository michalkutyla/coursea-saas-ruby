require "test/unit"

class CartesianProduct
  include Enumerable
  def initialize(a, b)
    @product = []
    a.each do |elt_a|
      b.each do |elt_b|
        @product << [elt_a, elt_b]
      end
    end
  end

  def each
    @product.each do |elt|
      yield elt
    end
  end
end

class TestAnagrams < Test::Unit::TestCase
  def test_empty
    c = CartesianProduct.new([:a,:b], [])
    assert_equal([], to_arr(c))
  end

  def test_simple
    c = CartesianProduct.new([:a,:b], [4,5])
    assert_equal([[:a, 4],[:a, 5],[:b, 4],[:b, 5]], to_arr(c))
  end

  def to_arr iterator
    arr = []
    iterator.each { |elt| arr << elt}
    arr
  end
end