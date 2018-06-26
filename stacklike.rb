module Stacklike

  #an array is saved in the instance variable @stack
  #it is made available by calling the stack method
  def stack
    @stack ||= []
  end

  #an object is added to the end of the stack by calling push on stack and passing it the object
  def add_to_stack(obj)
    stack.push(obj)
  end

  #we remove the last object from the stack by calling pop on stack
  def take_from_stack
    stack.pop
  end

end
