# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  autoload :Any, 'lookout/mock/method/arguments/any'
  autoload :Anything, 'lookout/mock/method/arguments/anything'
  autoload :List, 'lookout/mock/method/arguments/list'
  autoload :None, 'lookout/mock/method/arguments/none'

  Error = Class.new(Lookout::Mock::Error)

  def initialize(*args)
    self.args = args
  end

  def verify(*args)
    @args == args or
      raise Error, 'unexpected arguments: (%s)≠(%p)' %
        [args.map{ |arg| arg.inspect }.join(', '), @args]
  end

  def inspect
    result = @args.inspect
    result.empty? ? "" : '(%s)' % result
  end

protected

  def args=(args)
    return @args = Any.new if args.empty?
    none = args.find{ |arg| arg.is_a? None } and return @args = none
    @args = List.new(args)
  end
end
