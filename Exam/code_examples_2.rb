# code_examples_2.rb

# Classes and Objects
# Classes provide a form/mold for creating objects.
class Fruit
  def initialize(type, ripeness)
    @type = type
    @ripeness = ripeness
  end
end

apple = Fruit.new('apple', 'ripe')
pear = Fruit.new('pear', 'not yet')

# Use attr_* to create setter and getter methods
class Shoe
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

runners = Shoe.new('black')
# How to call setters and getters
runners.color # 'black'

# Instance vs class methods

class Car
  attr_reader :mileage
  @@total_cars = 0

  def initialize(mileage)
    @mileage = mileage
    @@total_cars += 1
  end

  def add_mileage(miles)
    @mileage += miles 
  end

  def self.total_cars
    @@total_cars
  end
end

kia = Car.new(10_000)
honda = Car.new(90_000)
kia.add_mileage(1_234)
p kia.mileage
p Car.total_cars

# Ref and set instance variables vs. using getters and setters
# Good for working with data when setting or getting a value

class Car
  attr_reader :color

  def initialize(mileage, color)
    @mileage = mileage
    @color = color
  end

  def mileage=(new_mileage)
    # also could convert to different units, etc, in here
    puts "Get an oil change." if (new_mileage - @mileage) > 4000
    @mileage = new_mileage
  end

  def mileage
    @mileage
  end
end

honda = Car.new(10_000, 'red')
honda.mileage = 20_000
p honda.mileage
p honda.color

# Class inheritance

class Animal
  def initialize(name, weight)
    @name, @weight = name, weight
  end
end

class Fish < Animal
  def can_swim?
    true
  end
end

# Encapsulation

class Cat
  def jump
    'It jumps!'
  end
end

class House
  def pay_bills
    ###
  end
end

my_house = House.new
brian = Cat.new
my_house.pay_bills # works
brian.jump         # works

# brian.pay_bills    # not available
# my_house.jump      # not available

# Polymorphism
class Bear
  def self.primary_food
    "Salmon, berries, and hikers."
  end
end

class Racoon
  def self.primary_food
    "Trash."
  end
end

p Bear.primary_food
p Racoon.primary_food

# Modules
# Good for applying same behavior to multiple classes
module Call
  def make_call(number)
  end
end

module Email
  def check_email
  end
end

class Computer
  include Email
end

class Phone
  include Call
end

class Smartphone
  include Email, Call
end

# Method lookup path
# Ruby searches up the inheritance chain until it finds the invoked
# method. If it doesn't, it returns a NoMethodError
module Call
  def make_call(number)
  end
end

module Email
  def check_email
  end
end

class Smartphone
  include Email, Call
end

class Smartphone # worth noting that done this way, 'Call' is searched before 'Email'
  include Email
  include Call
end
p Smartphone.ancestors
p Array.ancestors

# self
# references the object within an instance method, class withing the class
# but outside of an instance method

# Fake operators and equality

class Grades
  attr_reader :avg_grade
  def initialize(grades)
    @grades = grades
    @avg_grade = grades.inject(:+) / grades.size
  end

  def ==(other_student) # without this, only identical (based on object_id) objects are deemed equal
    avg_grade == other_student.avg_grade
  end
end

alex = Grades.new([90, 95, 93])
ted = Grades.new([92, 95, 91])
p ted == alex

# Truthiness
# Same rules hold, only nil and false are falsey, all other objects are truthy

# Working with collaborator objects
class Test
  attr_reader :grade

  def initialize(topic, earned_points, available_points)
    @topic = topic
    @grade = ((earned_points.to_f / available_points) * 100).to_i
    @earned_points, @available_points = earned_points, available_points
  end

  def to_s
    "Topic: #{@topic}\nScore: #{@earned_points} out of #{@available_points}\n\n"
  end
end

class Student_Grades
  attr_reader :tests

  def initialize(tests)
    @tests = tests
  end

  def avg_grade
    average = 0
    @tests.each { |test| average += test.grade }
    average = average / @tests.size
  end
end

alex = Student_Grades.new([test1 = Test.new('OOP', 90, 100), 
                           test2 = Test.new('HTTP', 95, 100),
                           final = Test.new('Ruby on Rails', 96, 100)])
p alex.avg_grade
puts alex.tests

# Private vs Protected Methods

class Account
  def initialize(balance)
    @balance = balance
  end

  def ==(other_account)
    @balance == other_account.balance
  end

  def withdraw(amount)
    @balance -= amount
    nil # prevents balance from being returned
  end

  def deposit(amount)
    @balance += amount
    nil # prevent balance from being returned
  end

  protected
  # line 7 won't work if this line says private

  attr_reader :balance
end

alex = Account.new(100)
ted = Account.new(100)
alex.deposit(55)
ted.deposit(65)
ted.withdraw(10)
p alex == ted

# Error Handling
# test.rb

class ValidateAgeError < StandardError; end

def validate_age(age)
  raise ValidateAgeError.new("invalid age") unless (0..105).include?(age)
end

begin
  validate_age(200)
rescue ValidateAgeError => e
  puts e.class
end
