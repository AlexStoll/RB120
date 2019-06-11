# medium_7.rb

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "Turn light on with a brightness level of superhigh and a color of green."
  end

end

puts Light.information