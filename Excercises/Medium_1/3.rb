# can only add or alter 5 lines of code
# Grad students can use on campus parking, undergrads can't
# Grad/undergrad have a name/year associated

# 5

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
end

bob = Undergraduate.new('Bob', 2)
marry = Graduate.new('Marry', 5, true)
p bob, marry