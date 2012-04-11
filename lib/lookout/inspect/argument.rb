# -*- coding: utf-8 -*-

# Non-failing inspection of arguments.  It’s used by {Mock::Method::Arguments},
# among others.
class Lookout::Inspect::Argument < Lookout::Inspect
  class << self
    # @param [Object, …] *arguments
    # @return [String] The inspections of _arguments_, separated by “, ”’s
    def list(*arguments)
      arguments.map{ |e| Lookout::Inspect::Argument.new(e).call }.join(', ')
    end
  end

  # @param [Object] argument The argument to inspect
  def initialize(argument)
    super argument, 'argument'
  end
end
