class Person
  attr_reader :first, :last

  def name=(string)
    @first, @last = string.split(' ')
  end

  def name
    "#{first} #{last}" # or skip the attr_reader and do "#{@first} #{@last}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
