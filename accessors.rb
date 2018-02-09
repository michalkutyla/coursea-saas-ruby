require "test/unit"

class Class
	def attr_accessor_with_history(attr_name)
		attr_name = attr_name.to_s  # make sure it's a string
		attr_writer attr_name # create the attribute's setter
		attr_reader attr_name  # create the attribute's getter
		attr_reader attr_name+"_history" # create bar_history getter		
		class_eval %Q{
		  
		  def #{attr_name}=(newBar)
		    if (@#{attr_name}_history == nil)
		       @#{attr_name}_history = [nil]
		    end
		    
		    @#{attr_name}_history += [newBar]
		    @#{attr_name} = newBar  
		  end
		  
		  def #{attr_name}_history
		     if (@#{attr_name}_history == nil)
		        @#{attr_name}_history = [nil]
		     end
		     @#{attr_name}_history
		  end}
	end
end

class Foo
	attr_accessor_with_history :bar
	attr_accessor_with_history :car
end

class TestAnagrams < Test::Unit::TestCase
  def test_simple
    f = Foo.new
	  f.bar = 1  
	  f.bar = 2
	  
	  f.car = 3
	  assert_equal([nil, 1, 2], f.bar_history)
	  assert_equal([nil, 3], f.car_history)
  end
  
  def test_is_instance
    f = Foo.new
    f.bar = 1
    f.bar = 2
    f = Foo.new
    f. bar = 4
    assert_equal([nil, 4], f.bar_history)
  end
end