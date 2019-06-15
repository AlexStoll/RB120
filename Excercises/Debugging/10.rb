class Person
  attr_accessor :name, :weight, :height

  @@total_people = 0

  def initialize(name, weight, height)
    set_info(name, weight, height)
    @@total_people += 1
  end

  def self.total_people
    @@total_people
  end

  def change_info(name, weight, height)
    set_info(name, weight, height)
  end

  def set_info(name, weight, height)
    @name = name
    @weight = weight
    @height = height
  end
end

bob = Person.new('Bob', 100, "5'11''")
bob.change_info('b', 1, 5)
p bob.name, bob.weight, bob.height