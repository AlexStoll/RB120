class Person
  def age=(age) # multiply age by two on assignment
    @age = double(age)
  end

  def age # multiply age by two on retrieval
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age # 80