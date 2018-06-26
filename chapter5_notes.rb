# Chapter 5: The default object (self), scope, and visibility
#
#   Scope
#   - to rules of scope govern the visibilty of variables
#   - it's important to know what scope you're in:
#     - so you can tell what variables refer to
#     - not confuse them with variables of different scopes with the same name
#     - nor confusee them with variables from similarly named methods
#
#   self
#   - isn't so much a concept as an object
#   - self changes in the course of a program
#   - at every moment only one object plays the role of self
#   - but it's not necessarily the same object from one moment to the next
#   - self in Ruby is like the first person I of the program
#
#   - self and scope are the master keys to orienting yourself in a Ruby program
#   - it's important to know what scope you're in and what object self is
#     - this will help tell you what's going on and to analyze errors
#
#   - to know which object is self you need to know which context you are in
#     - contexts include:
#       - top level of the program
#       - class definition
#       - module definition
#       - method definition
#
#   - self in class and module definitions
#     - self is the class or module object
#     - use: puts self to see what self is at various levels
#
#   - self in instance method definitions
#     - the code inside the method isn't executed until later,
#       when an object receives the message
#     - when the method is called,
#       self will be the object that called it
#       (the receiver of the message)
#     - self in singleton method and class method definitions
#     - when a singleton method is executed, self is the object that owns the method
#
#   - self as the default receiver of messages
#     - if the receiver of the message is self, you can omit the receiver and the dot
#       - example below
#     - most common use of dotless method call is when
#       you're calling one instance method from another
#
#     - resolving instance variables through self
#       - every instance variable belongs to whatever object is the current object (self)
#         at that point in the program
#
#   - determining scope
#     - scope refers to reach or visibility of identifiers, specifically variables and constants
#     - local and global variables differ as to scope
#     - scope changes over the course of a program
#
#   - global scope and global variables
#     - scope the covers the entire program
#     - global variables use the $ symbol
#     - global variables are available everywhere in a program
#     - global variables never go out of scope
#       - pros of global variables
#         - don't have to worry about scope
#         - multiple classes can share information
#       - cons of global variables
#         - you're supposed to have to query objects for information
#         - objects are supposed to have a certain privacy
#         - objects stop talking to each other and instead share information through global variables
#
#   - local scope
#     - at any given moment your program is in a particular local scope
#     - the main thing that changes from one local scope to another is your supply of local variables
#     - where local scopes begin and end
#       - top level (outside of all definition blocks) has its own local scope
#       - every class or module definition block as its own local scope
#       - every method definition (def) has its own local scope
#     - within class and module definitions, local variable code is executed as it's encountered
#     - local variables in methods aren't executed until an object is sent the appropriate message
#
#   - scope and resolution of constants
#     - if you know the chain of nested definitions, you can access a constant from anywhere
#     - if X is a constant nested in a series of modules and classes you can access it like this:
#       - M::C::D::N::X
#     - constant lookup is similar to a file path lookup in a computer directory
#       - it can be done using a relative or absolute path
#
#   - class variable syntax, scope, and visibility
#     - class variables begin with 2 @ symbols, ie. @@variable
#     - despite their name, class variables aren't class scoped
#     - class variables store info that is available
#       to the class and instances of the class
#       and not available to any other objects
#     - visibilty to a class and its instances and no one else
#     - being visible in class-method definitions and instance-method definitions,
#       and sometimes at the top of the class definition
#
#   - pros and cons of class variables to maintain state in a class
#     - instance variables are the bread and butter way to maintain state in a class
#     - class variables break down the dam between a class object and instances of that class
#     - a class variable becomes visible to a lot of objects once you add up all sublcasses and instances of those subclasses
#
#   - maintaining per-class state with instance variables of class objects
#
#   - method-access rules
#     - there are 3 access levels
#       1. public - default access level; most common
#       2. private
#       3. protected
#     - subclasses inherit the metho-access of their superclasses
#
#   - top-level methods
#     - A method that you define at the top level is stored as a private instance method of
#       the Object class.
#     - must be called in bareword style because they are private
#     - always available; can be called from anywhere in your code
#     - top-level methods provide simple, script-friendly, procedural-style bareword commands
#
#   - predefined (built-in) top-level methods
#     - ie. puts, print, require, load, raise

# dotless vs receiver plus dot

class C
  def C.no_dot
    puts "As long as self is C, you can call this method with no dot."
  end
  no_dot
end

C.no_dot

# calling one instance method from another

class C
def x
puts "This is method 'x'"
end
def y
puts "This is method 'y', about to call x without a dot."
x
end
end
c = C.new
c.y

# Composing whole name from values, using method calls on implicit self

class Person
  attr_accessor :first_name, :middle_name, :last_name

  def whole_name
    n = first_name + " "
    n << "#{middle_name} " if middle_name
    n << last_name
  end
end

tlj = Person.new

tlj.first_name = "Tommy"
tlj.last_name = "Jones"

puts "Tommy's whole name: #{tlj.whole_name}"
tlj.middle_name = "Lee"
puts "Tommy's new whole name: #{tlj.whole_name}"


######

class D
  puts "Just inside class definition block. Here's self:"
  p self

  @v = "I am an instance variable at the top level of a class body."
  puts "And here's the instance variable @v, belonging to #{self}:"
  p @v

  def show_var
    puts "Inside an instance method definition block. Here's self:"
    p self
    puts "And here's the instance variable @v, belonging to #{self}:"
    p @v
  end
end
d = D.new
d.show_var

######

# Keeping track of guitar manufacturing statistics with class variables

# class Guitar
#   # an array and stores the names of makes
#   @@makes = []
#   # a hash: keys are makes of guitars and whose corresponding values are counts of how many of each make there are.
#   @@guitars = {}
#   # a running tally of how many cars have been created overall
#   @@total_count = 0
#
#   # The attr_reader enables us to ask every guitar what its make is
#   # The value of the make attribute must be set when the guitar is created
#   # There’s no writer attribute, because we don’t want code outside the class changing
#   # the makes of guitar that already exist.
#   attr_reader :make
#
#   # To provide access to the @@total_count class variable, the Guitar class defines a
#   # total_count method, which returns the current value of the class variable.
#   def self.total_count
#     @@total_count
#   end
#
#   # a class method called add_make; this method takes a single argument and
#   # adds it to the array of known makes of guitar
#   def self.add_make(make)
#     # making sure the array of makes doesn’t already include this particular make
#     unless @@makes.include?(make)
#       # adds it to the array of known makes of guitar
#       @@makes << make
#       # sets the counter for this make’s guitar tally to zero.
#       @@guitars[make] = 0
#     end
#   end
#
#   # where new guitars are created
#   def initialize(make)
#     if @@makes.include?(make)
#       puts "Creating a new #{make}!"
#       # we set the guitar's make attribute to the appropriate value
#       @make = make
#       # increment by one the number of guitars of this make that are recorded in the @@guitars hash
#       @@guitars[make] += 1
#       # increment by one the total number of existing guitars stored in @@total_count
#       # @@total_count represents the total of all the values in @@guitars
#       @@total_count += 1
#     else
#       # if the make doesn't exist (isn't in the @@makes array, we raise an error)
#       raise "No such make: #{make}."
#     end
#   end
#
#   # instance method which returns a list of all guitars of a given guitars’s make
#   def make_mates
#     @@guitars[self.make]
#   end
# end
#
# Guitar.add_make("Fender")
# Guitar.add_make("Gretsch")
#
# f = Guitar.new("Fender")
# g = Guitar.new("Gretsch")
# f2 = Guitar.new("Fender")
#
# puts "Counting guitars of same make as f2..."
# puts "There are #{f2.make_mates}."
#
# puts "Counting total cars..."
# puts "There are #{Guitar.total_count}."
#
# t = Guitar.new("Taylor")


######

# Guitar with @@total_count replaced by instance variable @total_count

class Guitar
  @@makes = []
  @@guitars = {}

  attr_reader :make

  def self.total_count
    @total_count ||= 0
  end

  def self.total_count=(n)
    @total_count = n
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@guitars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}!"
      @make = make
      @@guitars[make] += 1
      self.class.total_count += 1
    else
      raise "No such make: #{make}."
    end
  end

  def make_mates
    @@guitars[self.make]
  end
end

class Acoustic < Guitar
end


Guitar.add_make("Fender")
Guitar.add_make("Gretsch")

f = Guitar.new("Fender")
g = Guitar.new("Gretsch")
f2 = Guitar.new("Fender")

f3 = Acoustic.new("Fender")
g2 = Acoustic.new("Gretsch")

puts "There are #{Acoustic.total_count} acoustics in the store!"

puts "Counting guitars of same make as f2..."
puts "There are #{f2.make_mates}."

puts "Counting total guitars..."
puts "There are #{Guitar.total_count}."

# t = Guitar.new("Taylor")


# a dog-years-aware Dog with private setter (=) methods

class Dog
attr_reader :age, :dog_years

def dog_years=(years)
  @dog_years = years
end

def age=(years)
  @age = years
  self.dog_years = years * 7
end

private :dog_years=
end

rover = Dog.new
rover.age = 10
puts "Rover is #{rover.dog_years} in dog years."


# Example of a protected method and its use

class C

  def initialize(n)
    @n = n
  end

  def n
    @n
  end

  def compare(c)
    if c.n > n
      puts "The other object's n is bigger."
    else
      puts "The other object's n is the same or smaller."
    end
  end

  protected :n
end

c1 = C.new(100)
c2 = C.new(101)

c1.compare(c2)


######

# defining a top-level method

# this
def talk
  puts "Hello"
end

# is equivalent to this
class Object
  private
  def talk
    puts "Hello"
  end
end

puts "Trying 'talk' with no receiver..."
talk
