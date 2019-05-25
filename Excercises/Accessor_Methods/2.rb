class Person
  attr_accessor :name
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica' # writer
person1.phone_number = '0123456789' # writer
puts person1.name # reader