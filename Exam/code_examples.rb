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

# Modules
# Mix ins -
# => Adding same functionality to multiple classes
# => Solves the problem of multiple inheritance
# Namespacing -
# => Containing class definitions inside of a module.
# => This allows one to be less concerned with accidentally
# => overwritting other methods of the same name

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





