# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  Error = Class.new(Lookout::Mock::Error)

  def initialize(*args)
    self.args = args
  end

  def verify(*args)
    @args == args or
      raise Error, 'unexpected arguments: (%p)≠(%p)' % [List.new(*args), @args]
  end

  def inspect
    result = @args.inspect
    result.empty? ? result : '(%s)' % result
  end

  protected

  def args=(args)
    return @args = Any.new if args.empty?
    # TODO: Raise errors here if args.length > 2 and args.find{ None } ?
    none = args.find{ |arg| None === arg } and return @args = none
    @args = List.new(*args)
  end
end
