# instance methods:
#   - methods defined inside a class
#     that are intended to be used by all instances of that class
#   - they don't belong to any one object
#
# singleton methods:
#   - if you define a method for one particular object
#       it is a singleton method
#
# overriding methods:
#   - once you define an instance method in a class
#     you can override it with a new one
#   - when you override a method the new version take precedence
#
# state:
#  - information and data associated with an object is its state
#  - need ability to set/reset that state of an object
#  - need ability to ask the object what its state is
#
# instance variable:
#  - storage and retrieval tool for values
#  - enables an individual object to remember its state
#  - always start with @
#  - only visible to the objects to which they belong
#  - an instance variable initialized in one method of
#    a particular class is the same as the instance method
#    of the same name referred to in other method names of
#    the same class
#
# initializing an object with state:
#   - use an initialize method to to give an object state upon creation
#
# setter methods
#   - let's you change an object's state after it's been initialized
#   - assigns/reassigns of an instance variable
#   - uses the "=" in method names
#
# syntactic sugar
#   - special rules that allow for more readable code
#   - in the case of calling a setter method, you don't need the spaces before or after
#     the = sign and the () are optional
#     Ex: bkb.address = "100 S Morgan"
#
# attribute methods aka attr_* methods
#   - attr_reader
#     - takes the place of the reader methods (getters)
#   - attr_writer
#     - take the place of the writer methods (setters)
#   - attr_accessor
#     - combo: takes the place of both reader and writer methods
#   - attr
#     - calling attr with true as 2nd argument triggers creation
#     - without 2nd argument of true it's only a reader (not a combo)
#       of both reader and writer attributes like attr_accessor above
#     - can only be called with 1 accesssor name at a time ie. :address
#     - attr_accessor is preferred because it's clearer in intent
#
# inheritance
#   - downward chaining relationship between classes
#     ( superclass and subclass)
#   - one class inherits from another
#   - instances of subclass acquire the methods defined in superclass
#
# single inheritance
#   - an object can inherit from only one class - only one superclass
#   - you can instead add many modules to add more methods
#
# creating class objects
#   - my_class = Class.new
#   - after you've created a class you then create instances of its own
#     ie. instance_of_my_class = my_class.new
#
# calling methods with a class object
#   - from within their class
#       - Gym is an instance of Class.
#       - Class defines an instance method called new.
#       - Call it with Gym.new
#   - from the superclass and earlier ancestors if its class
#       - the superclass of Class is Module
#       - instances of Class have access to the instance methods
#         defined in Module
#       - ex: attr_accessor is a method that comes from Module
#   - from a singleton method of a class object
#       - see the most_expensive class method below
#       - the method is defined directly on the Gym class in singleton-method style
#       - commonly referred to as a class method
#       - singleton/class method allows you to send a message directly
#         to the object that is the class rather than one of the class's instances
#       - the message most_expensive goes to the class Gym, not to a particular gym
#
# when and why to write class methods
#   - calling new on a class object
#       - until an instance object is created from the class you can't send it any messages
#   - calling open on a File class
#       - you're requesting the creation of an individual object from the class
#       - the class is acting as a point of departure for the object it creates
#   - the example below of calling most_expensive on the Gym class
#       - consider it an operation from above
#       - something that's done collectively with respect to gyms
#         rather than something that's done to an individual gym
#       - it's not unheard of to create a class only for the purpose of giving it class methods
#
# constants
#     - the name of a constant starts with a capital letter - see ACTIVITIES below
#     - constant definitions usually go at or near the top of the class definition
#     - a constant defined in a class can be referred to from inside the class's intance or class methods
#     - it's also possible to refer to it from outside the class definition
#       - use the double colon ie. ::
#       - example below: Gym::ACTIVITIES
#       - the double-colon references the constant ACTIVITIES inside the class Gym
#     - ruby has predefined constants
#       - Math::PI - the PI constant is found in the Math module
#     - despite its name constants can actually be reassigned or modified
#       - reassigning a constant
#       - this is changing the mapping of identifiers to objects
#         - for example, if A = 1 we can reassign it simply A = 2
#           - not recommended but can be done
#           - if the value needs to change use a variable instead of a constant
#       - modifying a constant
#         - you can make changes to the object to which the constant refers
#         - this is referred to changing the state or contents of the object
#         - see the example below where we added Slackline to the list of gym activities
#




class Gym

  ACTIVITIES = ["Top Rope", "Bouldering", "Lead Climbing", "Yoga", "Crossfit"]

  attr_reader :name, :cost#, :address
    attr_accessor :address
    #attr_writer :address
    #attr :address, true

  def initialize(name, cost)
    @name = name
    @cost = cost
  end

  # #writer method (setters)
  # def address=(address)
  #   @address = address
  # end
  #
  # #reader methods (getters)
  # def name
  #   @name
  # end
  #
  # def cost
  #   @cost
  # end
  #
  # def address
  #   @address
  # end



  #the most expensive method is called on the Gym class
  #we pass the method a list of gyms
  #the method identifies which gym has the most expensive cost
  def Gym.most_expensive(*gyms)
    gyms.max_by(&:cost)
  end

end

class Yoga < Gym
  attr_accessor :instructor
end

class Pose < Yoga

end

bkb = Gym.new("BKB Chicago",25)
bkb.address = "100 S Morgan"

fa = Gym.new("First Ascent Humboldt",20)
fa.address = "2950 W Grand"

#calling the most expensive class method on gym and passing it the list of gyms
#saving results to a variable called highest
highest = Gym.most_expensive(bkb, fa)

puts "The most costly day pass comes from #{highest.name} and costs #{highest.cost} per day."

puts "We've created two new gyms."
puts "The first is #{bkb.name}. Day passes cost #{bkb.cost}. We are located at #{bkb.address}."
puts "The second is #{fa.name}. Day passes cost #{fa.cost}. We are located at #{fa.address}."

vinyasa = Yoga.new(bkb.name, bkb.cost)

vinyasa.instructor = "Yoda"

puts "Welcome to Vinyasa Flow Yoga. Your instructor is #{vinyasa.instructor}."

puts "Activites at these gyms may include:"
#let's output the ACTIVITIES constant from the Gym class
puts Gym::ACTIVITIES
#or we can insert the value of the PI constant from the Math module
puts "Would you care for some #{Math::PI}? Enjoy your pie pun."

puts "Let's add Slackline to the list of possible activities available at these gyms"
activities = Gym::ACTIVITIES
activities << "Slackline"
puts activities
