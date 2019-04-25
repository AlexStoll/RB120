# excercises_chapter_1.rb

# Add a class method to the MyCar class that
# calculates the gas milage of any car

# Override the to_s method

# Where does the error in this code come from, how to fix?
class Person
  # attr_reader :name # This line is the issue. This is just a getter, not a setter
  attr_accessor :name # This will fix the problem, to allow setting.
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
# __________________________


class MyCar

  attr_accessor :color, :model, :speed, :number_of_cars
  attr_reader :year

  NEW_CAR_YEAR = 2019

  @@number_of_cars = 0

  def initialize(year, color, model)
    year == 'new' ? @year = NEW_CAR_YEAR : @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_cars += 1
  end

  def change_speed_by(num)
    self.speed += num
    puts "Reversing!" if self.speed < 0
  end

  def stop_car
    self.speed = 0
  end

  def repaint(color)
    self.color = color
  end

  def self.total_cars # class method definition
    @@number_of_cars
  end

  def self.mileage(miles, gallons)
    puts "#{miles / gallons} MPG"
  end

  def to_s
    "This is a #{self.color} #{self.year} #{self.model}."
  end
end

rav4 = MyCar.new(2016, 'Black', 'Rav4')
puts rav4
