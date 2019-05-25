# all to inherit from a common superclass
# car, motorcycle, truck < vehicle

class Vehicle
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  attr_reader :make, :model

  def wheels
    4
  end
end

class Motorcycle < Vehicle
  attr_reader :make, :model

  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    super + ", Payload: #{payload}"
  end
end

b = Truck.new('Ford', 'Ranger', 2000)
puts b.wheels
