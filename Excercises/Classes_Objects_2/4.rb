class Cat
  attr_reader :name

  def self.generic_greeting
    puts "Cat class here."
  end

  def personal_greeting
    puts "Cat named #{name}"
  end

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
