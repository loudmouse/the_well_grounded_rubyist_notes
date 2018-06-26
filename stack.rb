#require_relative takes a string as its argument, hence stacklike is in quotes
require_relative "stacklike"
class Stack
  #mixing in the Stacklike module
  #include takes the name of a module, a constant, as its argument so no quotes
  include Stacklike
end

#instantiates a new stack object
s = Stack.new

#calls one of the methods a few times from the Stacklike module we included above which adds item to end of array
s.add_to_stack("item one")
s.add_to_stack("item two")
s.add_to_stack("item three")

#the object is asked to tell us its state by calling another module method on it
puts "Objects currently on the stack:"
puts s.stack

#call another module method this time to remove an item from the end of the array
taken = s.take_from_stack
puts "Removed this object:"
puts taken

#report again on the state of the object's array contents
puts "Now on stack:"
puts s.stack

# #Now for comparison, let's accomplish the same thing within a class without the module
# class Stack
# attr_reader :stack
#
#   def initialize
#     @stack = []
#   end
#
#   def add_to_stack(obj)
#     @stack.push(obj)
#   end
#
#   def take_from_stack
#     @stack.pop
#   end
# end
#
# s2 = Stack.new
#
# s2.add_to_stack("item 1")
# s2.add_to_stack("item 2")
# s2.add_to_stack("item 3")
#
# puts "Objects in stack currently include:"
# puts s2.stack
#
# removed = s2.take_from_stack
# puts "Object taken from stack:"
# puts removed
# puts "Now on the stack:"
# puts s2.stack
