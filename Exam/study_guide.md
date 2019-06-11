**Topics**

* Classes and objects

* Use `attr_*` to create setters and getters

* How to call setters and getters

* Instance vs class methods
  * Instance methods - operate on instances of the class
  * Class methods - operate at the level of the class itself. Less common but are used to work with class level data, like class variables
  ```ruby
  def self.what_am_i
    "I'm the Dog class!"
  end
  ```

* Referencing and setting instance variables vs. using
  getters and setters
  * getters and setters are useful if you don't need to do anything to your data when setting or getting
  * a bespoke method is useful when you need to execute some logic when getting or setting instance variables. For instance, capitalizing a name when setting.
  ```ruby
  class People
  attr_reader :name

  def name=(string)
    @name = string.capitalize
  end
end

bob = People.new
bob.name = 'bob'
p bob.name # => 'Bob'
  ```


* Class inheritance, 'encapsulation', 'Polymorphism'

  * Encapsulation - making pieces of functionality unavailable to the rest of the code base. A form of data protection. Defines boundaries in the application and allows greater complexity. Accomplished through objects and methods.
  * Also allows for a higher level of abstraction

  * Polymorphism - the ability for different object to respond in different ways to the same message (or method)
    * Through inheritance - a method can be defined in a subclass, so it will behave differently depending on whether the parent or child class is calling it.
  * Duck typing - this allows objects of different classes to be called with the same method name. Within each object's class definition, that method name will be different and specific to the class.

```ruby
class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end
```
The above example shows that `Chef` and `Decorator` objects can call a `prepare_wedding` method. What that method then actually does is specific to the class.

* Modules
  * Collection of behaviours useful in other classes
  * Can be mixed in using `include`
  * Solves the issue of 'multiple inheritance'
  * Can't create an object from a module (what about within a class within a module???)
  * to namespace? i.e. put classes in a module?

  * Namespacing - organizing similar classes under a module
  * It makes it easier to recognize related classes
  * It reduces the likelhood of classes colliding with other classes of the same name


* Class variables
  * Used to work with information on the entire class
  * `@@number_of_dogs` might be used to track the number of instances of the `Dog` class that have been created


* Method lookup path
  * The path that ruby searches for a method name when invoked
  * Starts with the class, then any modules (bottom up), then Object, Kernel, BasicObject

* self
  * use self to specify a certain scope
  * means different things depending on where it's used
    1. Use self when calling setter methods from within the class
    2. Use self for class method definitions
  * Within the class, when an instance method calls `self`, it returns the 'calling object'
  * In a class, outside of a method, `self` returns the class itself.

* super
  * super automatically forward arguments passed to the method from which super is called to the method in the parent class
  * can use super() to skirt this behavior, and keep the arguments for use later in the method

* Inheritance vs Modules
  * If it's an "is - a" relationship - inheritance
  * If it's a "has - a" relationship - Module
  * A dog "is - an" `Animal` and "has - an" ability to `Swim`

* Public vs private vs protected methods
  * Public method is available anywhere in the program
  * Private methods are only available to other methods within the same class
  * Protected methods are unavailble outside the class, but accessible within the class. So you can call a method from outside the class which uses a protected method. You can't do that if it were to use a private method.

* Reading OO code

* Fake operators and equality
* Equality - `==` is a method which should be overriden to specify which value to compare, it defaults to comparing whether the two are the 'same' object.
  * Built-in classes override this method to compare objects
  
* `equal?` compares the values and object_id's
* `===` 'is a member of the set'
* `(1..50) === 25 => true`
* eql? determines same value and same class, not often used

* Truthiness

* Working with collaborator objects
  * Collaborator objects - Objects stored as a state within another object
    * so technically that's everything, but we typically are talking about objects of custom classes
  * They can connect various parts of your program
  * For example a `Person` object can have a `@pets` variable whose state is a `Cat` object
  * 

* Note on accessing variables in other classes
```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS
  end
end

kitty = Cat.new
kitty.legs   
```
* can use `::` on classes, modules, or constants
* class varaibles allow sub-classes to override super-class class variables, this then affects all other sub-classes of the super-class

* Fake Operators - many things that look like operators are actually methods which can be overriden
* The only actual operators in ruby are -
`&&` `||` `..` `...` `? :` `=` `%=` - and the other assignment shortcuts. `{}`
* Which should be overriden?
* The comparison methods like `==`, `>` or `>=`
* `<<` to easilly append items
```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)

cowboys << emmitt

cowboys.members   # => [#<Person:0x007fe08c209530>]
```


