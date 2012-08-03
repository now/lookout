# -*- coding: utf-8 -*-

# Non-failing inspection of arguments.  It’s used by {Reception::Arguments},
# among others.
class Lookout::Inspect::Argument < Lookout::Inspect
  class << self
    # @param [Object, …] arguments
    # @return [String] The inspections of ARGUMENTS, separated by “, ”’s
    def list(*arguments)
      arguments.map{ |e| Lookout::Inspect::Argument.new(e) }.join(', ')
    end
  end

  # Non-failing inspection of an ARGUMENT.
  # @param [Object] argument
  def initialize(argument) super argument, 'argument' end
end
