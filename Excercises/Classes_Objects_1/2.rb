module Walkable
  def walk
    puts "Walk"
  end
end

class Cat
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "My name is #{name}"
  end
end

kitty = Cat.new('Sasha')
kitty.greet
kitty.name = 'Luna'
kitty.walk