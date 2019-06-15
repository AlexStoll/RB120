# Code examples for certain OOP concepts

# Using atr_* to create setter and getter methods
class Car
  attr_reader :wheels
  attr_writer :color
  attr_accessor :price

  def initialize(w, c, p)
    @wheels, @color, @price = w, c, p
  end

end

# How to call setters and getters
bug = Car.new(4, 'Red', 600)
bug.color = 'Red'
puts bug.wheels
bug.price = 500
puts bug.price

# Instance vs Class methods
class Laptop
  def initialize(brand, size)
    @brand, @size = brand, size
  end

  def self.about
    puts "This class creates and stores information about laptop objects."
  end

  def to_s
    "A #{@size} inch #{@brand} laptop."
  end
end

Laptop.about
macbook_pro = Laptop.new('Apple', '13')
puts macbook_pro

# Referencing and setting instance variables vs. using getters and setters.
class SomeClass
  attr_accessor :banana

  def initialize(a, b)
    @apple, @banana = apple, banana
  end

  def apple=(value)
    @apple = value.capitalize
    # This style is useful for manipulating data.
  end

  def apple
    @apple
  end
end

instance = SomeClass.new('gala', 'yellow')
instance.apple = 'honeycrisp'
p instance.apple
instance.banana = 'squished'
p instance.banana

# Class inheritance (also polymorphism b/c of jump method)
class Dog
  def initialize(name)
    @name = name
  end

  def jump
    puts "#{@name} jumps!"
  end
end

class Corgi < Dog
  def initialize(name)
    super(name)
    @size = 'small'
    @demeanor = 'energetic'
  end

  def jump
    10.times {super}
  end
end
frank = Dog.new('Frank')
frank.jump
bobby = Corgi.new('Bobby')
bobby.jump

# Encapsulation
# Hiding functionality from other parts of the code base.
# It's a way of defining boundaries and safely adding complexity.
# 

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def meow
    "#{name} says meow"
  end
end

class Dog
  def initialize(name)
    @name = name
  end
end

bob = Cat.new('Bob')
puts bob.meow
ted = Dog.new('Ted')
# puts ted.meow # NoMethodError


# Modules
# Mix ins -
# => Adding same functionality to multiple classes
# => Solves the problem of multiple inheritance
# Namespacing -
# => Containing class definitions inside of a module.
# => This allows one to be less concerned with accidentally
# => overwritting other methods of the same name

# namespacing example
module CustomStructures
  class Array < Array
    # some custom implementation of an Array class
    def initialize
      puts "This is a custom array object."
    end
  end

  class Hash
    # some seperate implementation of a Hash class
  end
end

potato = CustomStructures::Array.new
tomato = Array.new
p potato.class
p tomato.class
# Method lookup path
# Class, then modules bottom - up, Object, Kernel, BasicObject

# Self
#   Calling methods with self
#   self returns the instance within an instance method
#   self returns the class within the class, out of a method

# Fake operators and equality
# Most operators are actually methods
# 

# Truithiness

# Collaborator objects
# Setting an object to the value of another custom object

# Polymorphism
# Also duck typing

class Circle

  Pi = 3.14159

  def initialize(radius)
    @radius = radius
  end

  def perimeter
    2 * Pi * @radius
  end

  def area
    Pi * (@radius ** 2)
  end
end

class Square
  def initialize(side)
    @side = side
  end

  def perimeter
    4 * @side
  end

  def area
    @side ** 2
  end
end

square = Square.new(10)
circle = Circle.new(10)
square.area # uses Circle's #area method
circle.area # uses Square's #area method

# Benefits of a custom setter or getter
class Car
  MilesToKm = 1.60934
  CircumferenceEarthInMiles = 24901

  def initialize(car, mileage)
    @car = car
    @mileage = mileage
  end

  def mileage(units='miles')
    case units
      when 'miles'
        @mileage
      when 'kilometers'
        @mileage * MilesToKm
      when 'earths'
        @mileage.to_f / 24901
    end
  end
end

jeep = Car.new('Jeep', 150_000)
p jeep.mileage('kilometers')
p jeep.mileage('earths')

# Multiple Inheritance
# The problem
class Phone
  def make_call(number)
  end
end

class Computer
  def check_email
  end
end

class Smartphone
  # needs computer and phone capabilities
end

# The fix
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

# protected method
# comparison of state of two objects
# => using attr_reader and def ==(other)

# private method


