# stack machine interpretation

# write a class that implements a miniature stack and register
# based language that has the following commands

# n - Place a value n in the 'register'. Do not modify the stack.
# PUSH - push the register value on to the stack, leave value in register.
# ADD - pops a value from the stack, adds it to the register, storing result in register
# SUB - pops value from stack, subtracts from register, storing result in register
# MULT - as above
# DIV - as above
# MOD - as above with modulo
# POP - Remove topmost item from stack and place in register
# PRINT - Print the register value

# Programs passed in via a string.
# Should produce error if unexpected item is in string
# or if stack is empty
# Initialize register to 0.
require 'set'

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  class MinilangError < StandardError; end
  class BadTokenError < MinilangError; end
  class EmptyStackError < MinilangError; end

  def initialize(program)
    @program = program
  end

  def eval
    @stack = []
    @register = 0
    @program.split.each { |token| eval_token(token) }
  end

  private

  def eval_token(token)

    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)