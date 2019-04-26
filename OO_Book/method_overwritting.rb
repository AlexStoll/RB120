# method_overwritting.rb

class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def instance_of?
    p "I'm a fake instance"
  end

end

son = Child.new
p son.instance_of?
