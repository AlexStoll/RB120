# initialize.rb

class GoodDog
  attr_accessor :name, :weight, :height

  def change_info(n, h, w)
    self.name, self.weight, self.height = n, h, w
  end

  def initialize(n, w, h)
    @name, @weight, @height = n, w, h
  end

  def speak
    puts "#{name} says 'woof'"
  end

  def info
    "#{name} weighs #{weight} lbs and is #{height} inches tall."
  end
end



theroy = GoodDog.new('Theroy', 135, 24)
theroy.speak
theroy.change_info('Doug', 90, 10)
puts theroy.info

# Initialize is called when a new object of the class
# is created
