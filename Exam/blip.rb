class Dog
  def initialize(name)
    @name = name
  end

  def say_hello
    puts "Woof! My name is #{@name}"
  end
end

=begin

This code defines a class 'Dog' with two methods.
The `#initialize` method is defined with the parameter name.
The instance variable @name is set to the value of the `name` parameter.
The `#say_hello` instance method prints the string, which will contain
the value referenced by `@name`, and return `nil`.

=end

