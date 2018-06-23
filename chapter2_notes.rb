# Open a stripped down IRB by typing this in terminal:
# irb --simple-prompt

# Method Argument Syntax
#
# required: a and b are required
# required: e and f are required
# default: c will default to 1 if you don't pass it an argument
# optional: d will take any extra arguments that are passed and added to an array


# def arg_demo(a,b,c=1,*d,e,f)
#   puts "required: #{a} and #{b}"
#   puts "required: #{e} and #{f}"
#   puts "default: #{c}"
#   puts "optional: #{d}"
# end
#
# arg_demo(1,5,6,2,1,7,9)

# arguments you send to methods are assigned to local variables
# that can be viewed and used for the duraton of the method
