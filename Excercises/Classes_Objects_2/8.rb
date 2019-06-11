# Create class named Person, @secret
# Use setter to add a value and a getter to print

class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh... secret.'
puts person1.secret
# 'Shh... secret.'