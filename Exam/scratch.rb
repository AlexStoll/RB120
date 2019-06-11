class Circle

  Pi = 3.14159

  def initialize(radius)
    @radius = radius
  end

  def perimeter
    2 * Pi * @radius
  end

  def area
    Pi * (@radius ** 2)
  end
end

class Square
  def initialize(side)
    @side = side
  end

  def perimeter
    4 * @side
  end

  def area
    @side ** 2
  end
end

square = Square.new(10)
circle = Circle.new(10)


# Benefits of a custom setter or getter

class Car
  MilesToKm = 1.60934

  def initialize(car, miles)
    @car = car
    @miles = miles
  end

  def miles(units='miles')
    units == 'kilometers' ? @miles * MilesToKm : @miles
  end
end

jeep = Car.new('Jeep', 15000)
p jeep.miles('kilometers')
p jeep.miles
