# Chapter 4: Modules & Program Organization
#
#   - modules are bundles of methods and constants
#   - modules don't have instances
#   - you specify that you want the functionality of a module
#     to be added to the functionality of a class of a specific object
#   - strength: modules help with program design and flexibility
#   - modules encourage modular design
#   - class Class is a subclass of the class Module
#   - modules get mixed in to classes using the 'include' method
#     - this is called a 'mix-in'
#     - instances of the class can call the instance methods defined in the module
#     - mixing in a module is similar to inheriting from a superclass
#     - you can mix in multiple modules in a single class
#     - compare this to a class which can only inherit from one class
#   - modules allow you to share code with more than one class
#     - any number of classes can mix in the same module
#   - modules give a way to collect and encapsulate behavior
#   - when you’re designing a program and you identify a behavior or
#     set of behaviors that may be exhibited by more than one kind of entity
#     or object, you’ve found a good candidate for a module
#   - a common practice but not required:
#     - class names are nouns and modules are adjectives
#     - ie. the class is Stack (noun) the module is Stacklike (adjective)
#       - could be said: Stack objects are stackable
#       - a stack is LIFO (last in, first out)
#         - adding/removing a plate to a stack of plates
#       - a queue is FIFO (first in, first out)
#         - entering and exiting a lunchroom line
#   - method lookup: an object looks for  method in this order:
#     1. its own class
#     2. modules mixed into its class (in reverse order if multiple modules)
#     3. the class's superclass
#     4. modules mixed into the superclass (again, in reverse order)
#     5. repeat 3 and 4 up to Object, it's mixin module Kernel, and lastly BasicObject
#   - if a method is listed twice in the same class or module the 2nd definition takes precedence
#   - using the 'super' keyword
#     - jumps up to the next highest definition, in the method lookup path,
#       for the method you are currently executiing
#     - example below to make a tandem almost like a bicycle
#       - change only what needs to be changed ie. number of seats
#       - super triggers the earlier initialization method
#         - this sets bicycle-like defaults for the other properties of tandem
#         - super can be called in 3 ways
#           - super  - most commonly called with no arguments.
#             Automatically forwards the arguments that were passed
#             to the method from which it's called.
#           - super()  - called with an empty argument list.
#             it sends no arguments even if arguments were provided in the original
#           - super(a,b,c)  - called with specific arguments.
#             it sends exactly those arguments
#   - the method_missing method
#     - provided in the Kernel module
#     - is executed when an object receives a message it doesn't know how to respond to
#       - ie. a message that doesn't match a method in the object's method lookup path
#     - you can override a missing_module method message in the following places:
#       - a singleton basis for the object you're calling the method on
#       - in the object's class
#       - in the class of its ancestors
#     - to override you must imitate the method signature
#       - the first argument is the name of the missing method
#       - the *args parameter sponges up any remaining arguments
#   - class/module design and naming
#     - mix-ins or inheritance
#       - both are closely related and you may choose to use one or the other in your program design
#       - with inheritance keep in mind a class gets only one inheritance so use it wisely
#     - for class vs module design decisions, keep in mind:
#       - modules don't have instances, ie. they can't be instantiated
#         - entitites or things are generally best modeled in classes
#         - characterstics or properties of entitites or things are best encapsulated in modules
#         - class names tend to be nouns (ie. Stack)
#         - module names tend to be adjectives (ie. Stacklike)
#       - a class can have only one superclass but limitless module mix-ins
#         - give priorty to creating a sensible superclass/subclass relationship
#         - don't use up a class's only superclass relationship to endow the class
#           with several sets of characteristics
#   - nesting modules and mix-ins
#     - you can next a class definition inside a module definition
#       - example: h = Tools::Hammer.new
#       - nested module/class chains are sometimes used
#         to create separate namespaces for class, modules, and methods
#           - example: Tools::Hammer and Piano::Hammer
#             - the two hammer classes won't conflict because they are in separate namespaces


#Create a module
module MyFirstModule
  def say_hello
    puts "Hello"
  end
end

#Include the module in a class (mix-in)
class ModuleTester
  include MyFirstModule
end

#Create a new object from the class
mt = ModuleTester.new
#call the mix-in method on the instance of the object
mt.say_hello


######

# example of using the super keyword
class Bicycle
  attr_reader :gears, :wheels, :seats

  def initialize(gears = 1)
    @wheels = 2
    @seats = 1
    @gears = gears
  end
end

class Tandem < Bicycle
  def initialize(gears)
    super
    @seats = 2
  end
end

######

# example of method_missing
# >> o = Object.new
# => #<Object:0x53ff34>
# >> o.blah
# NoMethodError: undefined method 'blah' for #<Object:0x53ff34>

# example of overriding method_missing
# >> def o.method_missing(m, *args)
# >> puts "You can't call #{m} on this object; please try again."
# >> end
# => nil
# >> o.blah
# You can't call blah on this object; please try again.

######

# inheritance vs. mix-ins

# don't do this
  # module Vehicle
  # ...
  # class SelfPropelling
  # ...
  # class Truck < SelfPropelling
  # include Vehicle
  # ...

# instead do this
  # module SelfPropelling
  # ...
  # class Vehicle
  # include SelfPropelling
  # ...
  # class Truck < Vehicle
  # ...
