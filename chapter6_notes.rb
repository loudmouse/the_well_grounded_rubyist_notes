# Control-flow Techniques:
#   - conditional execution: depends on the truth of an expression
#   - looping: a single segment of code is executed repeatedly
#   - iteration: a call to a method is supplemented with a segment of code that
#       the method can call one or more times during its own execution.
#   - exceptions: error conditions are handled by special control-flow rules
#
#   - conditional code execution
#     - if condition
#       code is executed if condition1 is true
#     - else
#       code is executed if condition1 is false
#       and condition2 is true
#     - elsif
#       code is executed if neither condition1
#       nor condition2 is true,
#       but condition3 is
#     - else
#       this final else clause is executed
#       if none of the previous tests for truth has succeeded.
#
#       * If none of the conditions is true and there is no else clause,
#         the whole if statement terminates with no action.
#
#     - negating conditions
#       - not
#         if not (x == 1)
#       - ! (bang)
#         if !(x == 1)
#       - unless (more natural-sounding)
#         unless x == 1
#
#     - conditional modifiers (good when you need a simple conditional)
#       - puts "Big number!" if x > 100
#       - puts "Big number!" unless x <= 100
#
#     - case statements (example below)
#       - when
#
#   - repeating actions with loops
#     - you can repeat an action while a given condition is true
#     - you can repeat an action until a given condition is true
#
#   - controlling the loop
#     - break - exits loop if conditionl is true
#     - next - skips to next iteration of loop if conditional is true
#
#   - conditional looping with while and until
#     - while
#       - run a loop while a condition is true
#     - until
#       - same as while but with reverse logic
#
#   - looping based on a list of values
#     - for/in keyword pair
#
#   - Iterators & Code Blocks
#     - loop is an example of an interator
#     - an iterator is a Ruby method that expects a code block
#     - loop has access to the code in the block and can execute that code block
#
#     - times
#       - a method called on an integer and runs the code block n times depending on
#         the integer it is called on
#
#     - each
#       - you run the method on a collection object
#         - each yields each item in the collection to your code block, one at a time
#
#     - map
#       - called on an array
#       - works through an array one item at a time
#       - calls the code block on each item
#       - creates a new array from the results of the code block
#         being called on each item of the original array
#
#     - each vs. map
#       - each returns the original receiver
#       - map returns a new array
#
#   - Block parameters and variable semantics
#     - method parameters are surrounded by parentheses ( )
#     - block parameters are surrounded by pipes | |



# Interpreting user input with a case statement
  print "Exit the program? (yes or no):"
  answer = gets.chomp
  case answer
  when "yes", "y" #can include multiple matches
    puts "Good-bye!"
    exit
  when "no", "n"
    puts "Ok, we'll continue."
  else
    puts "That's an unknown answer -- assuming you meant no."
  end

  puts "Continuing with program"

# Implementing case statement behavior for the Ticket class
  class Ticket
    attr_accessor :venue, :date
    def initialize(venue, date)
      self.venue =  venue
      self.date = date
    end

    def ===(other_ticket)
      self.venue === other_ticket.venue
    end
  end

  ticket1 = Ticket.new("Town Hall", "07/08/06")
  ticket2 = Ticket.new("Conference Center", "07/08/06")
  ticket3 = Ticket.new("Town Hall", "08/09/06")

  puts "ticket1 is for the event at: #{ticket1.venue}."

  case ticket1
  when ticket2
    puts "same location as ticket2!"
  when ticket3
    puts "same location as ticket3!"
  else
    puts "No match."
  end

# THE SIMPLE CASE TRUTH TEST
# case keyword without a test expression
  case
  when Time.now.wday == 5 then
    puts "It's Friday!"
  when Time.now.wday == 3
    puts "It's hump day!"
  else
    puts "It's not hump day nor Friday, bummer."
  end

# using the break keyword
  n = 1
  loop do
    n = n + 1
    break if n > 9
  end

  # next - skip to the next iteration of the loop without finishing current iteration
  n = 1
    loop do
    puts n
    n = n + 1
    next unless n == 10
    break
  end

  # while
  n = 1
  while n < 11
    puts n
    n = n + 1
  end
  puts "Done!"

  # print 1 to 10 using until
  n = 1
  until n > 10
    puts n
    n = n + 1
  end

  # another until
  n = 1
  n = n + 1 until n == 10
  puts "We've reached 10!"

  # for/in keyword pair for looping through an array
  age = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
  puts "Age + Ten"
  for a in age
    puts "age: #{a+10}"
  end
