# play.rb

require 'ripper'
require 'pp'

puts RubyVM::InstructionSequence.compile("hash = Hash.new(0)").disassemble