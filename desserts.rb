require "test/unit"

class Dessert
  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  attr_accessor :name
  attr_accessor :calories

  def healthy?
    return @calories < 200
  end

  def delicious?
    return true
  end
end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  attr_accessor :flavor

  def delicious?
    return @flavor != 'black licorice'
  end
end

class TestDessert < Test::Unit::TestCase
  def test_settery
    dessert1 = Dessert.new("mus", 200)
    assert_equal("mus", dessert1.name)
    assert_equal(200, dessert1.calories)
    dessert1.calories=10
    dessert1.name="krem"
    assert_equal("krem", dessert1.name)
    assert_equal(10, dessert1.calories)
  end

  def test_healty
    assert(Dessert.new(nil, 20).healthy?)
    assert(!Dessert.new(nil, 250).healthy?)
  end

  def test_jelly_bean
    jelly = JellyBean.new("jelly1", 20, "flavour")
    assert_equal("jelly1", jelly.name)
    assert_equal(20, jelly.calories)
    assert_equal("flavour", jelly.flavor)
    assert(!JellyBean.new(nil, 0, 'black licorice').delicious?)
    assert(JellyBean.new(nil, 0, 'whatever').delicious?)
  end
end