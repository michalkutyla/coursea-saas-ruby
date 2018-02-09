require "test/unit"

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
  def method_missing(method_id)
    singular_currency = normalize_currency_name(method_id)
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
  
  def normalize_currency_name(name)
    name.to_s.gsub( /s$/, '')
  end
  
  def in(currency)
    currency = normalize_currency_name(currency)
    inversed_rate = @@currencies[currency]
    self / inversed_rate
  end
end

class TestAnagrams < Test::Unit::TestCase
  def test_assumptions
    assert_equal(0.019, 1.rupee)
    assert_equal(1, 1.dollar)
  end
  
  def test_complex
    assert_equal(0.019, 1.rupee.in(:dollar))
    assert_equal(1.292, 1.euro.in(:dollar))
    assert_equal(0.013, 1.yen.in(:dollars))
    assert_equal(1, 1.dollar.in(:dollar))
  end
end