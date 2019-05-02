
class Cat
  attr_accessor :name, :color
  COLOR = ['black', 'white', 'purple']

  def initialize(name)
    @name = name
    @color = COLOR.sample
  end

  def greet
    puts "I'm a #{color} cat named #{name}."
  end
end


kitty = Cat.new('Sophie')
kitty.greet