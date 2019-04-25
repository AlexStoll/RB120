# classes_objects_II.rb

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

  def to_s
    "This #{model} was made in #{year} and is #{color}."
  end

  def what_is_self
    self
  end

end

bucket = MyCar.new(1994, 'Rust', 'Bucket')
geo = MyCar.new(1985, 'Taupe', 'Metro')
rav4 = MyCar.new('new', 'Black', 'RAV4')
p rav4.what_is_self