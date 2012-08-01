# -*- coding: utf-8 -*-

# Arguments that should be passed to a method reception expectation.  Sets
# things up based on what kind of arguments were passed to it and may then be
# used to {List#=~ verify} that arguments that don’t {Lookout::Difference
# differ} from them are subsequently passed to the method.
module Lookout::Reception::Arguments
  class << self
    # @param [Object, …] args
    # @return [Any, List, None] {Any} if _args_ is #empty?, {Any} or {None} if
    #   _args_ contain either, or a {List} wrapping _args_
    def for(*args)
      if args.empty? then Any.new
      elsif any = args.find{ |e| Any === e } then any
      elsif none = args.find{ |e| None === e } then none
      else List.new(*args)
      end
    end
  end
end
