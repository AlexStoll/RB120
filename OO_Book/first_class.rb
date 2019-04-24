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

franklin = GoodDog.new
jerry = Person.new

franklin.speak('Aawooff')
jerry.speak('Hi how aaare ya?')