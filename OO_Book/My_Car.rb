# My_Car.rb

module Payload
  def remaining_payload(max, current_load)
    "#{max - current_load}lbs remaining"
  end
end

class Vehicle

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has #{@@number_of_vehicles} vehicles."
  end

  def initialize
    @@number_of_vehicles += 1
  end

   def self.mileage(miles, gallons)
    puts "#{miles / gallons} MPG"
  end
end

class MyCar < Vehicle
  attr_accessor :color, :model, :speed, :number_of_cars
  attr_reader :year

  NUMBER_OF_DOORS = 4
  NEW_CAR_YEAR = 2019

  @@number_of_cars = 0

  def initialize(year, color, model)
    year == 'new' ? @year = NEW_CAR_YEAR : @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_cars += 1
  end

  def self.total_cars # class method definition
    @@number_of_cars
  end
end

class MyTruck < Vehicle
  include Payload
  NUMBER_OF_DOORS = 2
end


car = Vehicle.new
truck = MyTruck.new
other_car = MyCar.new(2, "blue", 'rover')

puts MyCar.ancestors
puts ''
puts Vehicle.ancestors
puts ''
puts MyTruck.ancestors





