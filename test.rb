module Swim
  def swim
    'swimming!'
  end
end


class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  include Swim

  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end


class Bulldog < Dog
  def speak
    "arf"
  end
end

class Fish
  include Swim
end


class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new('Robert')
bud = Bulldog.new
kitty = Cat.new


bob.pets << bud << kitty # setting bob's @pet instance to the 'bud' Bulldog object
bob.pets.each(&:jump)
