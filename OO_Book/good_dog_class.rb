# good_dog_class.rb

# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end


# class GoodDog < Animal # GoodDog 'inherits' from Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# class Cat < Animal # More inheritance
# end

# fido = GoodDog.new(4, 'Poncho')
# p fido

# module Swimmable
#   def swim
#     "I'm swimming!"
#   end
# end

# class Animal; end

# class Fish < Animal
#   include Swimmable         # mixing in Swimmable module
# end

# class Mammal < Animal
# end

# class Cat < Mammal
# end

# class Dog < Mammal
#   include Swimmable         # mixing in Swimmable module
# end

# trout, troy, rhino = Fish.new, Dog.new, Mammal.new
# p trout.swim, troy.swim
# p rhino.swim

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private # methods below here are only accessible to 
          # other methods in the class
          # So, helper methods could go here, so they can't
          # be called on their own.

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky.human_years
