class Fixnum
  def seconds ; self ; end

  def minutes ; self * 60 ; end

  def hours ; minutes * 60 ; end

  def ago ; Time.now - self ; end

  def from_now ; Time.now + self ; end

  def method_missing(method_id, *args)
    name = method_id.to_s
    if name =~ /^second|minute|hour$/
      self.send(name + 's')
    else
    super # pass the buck to superclass
    end
  end
end

puts Time.now
puts 5.minutes.ago
puts 3.hours.from_now
puts 1.hour.from_now

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
end

puts 1.euros
puts 1.euro
