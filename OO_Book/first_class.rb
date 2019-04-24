# good_dog.rb

module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class Person
  include Speak
end

puts "GoodDog ancestors \n\n"
puts GoodDog.ancestors
puts ''
puts "Person ancestors"
puts Person.ancestors