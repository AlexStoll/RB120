# classes_objects_ex.rb

class MyCar

  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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
end

bucket = MyCar.new(1994, 'Rust', 'Bucket')
bucket.repaint('Auburn')
p bucket.color