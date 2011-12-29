# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  Error = Class.new(Lookout::Mock::Error)

  def initialize(object, method, *args)
    @object, @method = object, method
    @args = if args.empty? then Any.new
            elsif any = args.find{ |e| Any === e } then any
            elsif none = args.find{ |e| None === e } then none
            else List.new(*args)
            end
  end

  def verify(*args)
    @args =~ args or
      raise Error,
        '%s received #%s(%p), expected #%s(%p)' %
          [Lookout::Inspect.new(@object, 'object').call,
           @method, List.new(*args),
           @method, @args]
  end

  def inspect
    (result = @args.inspect).empty? ? result : '(%s)' % result
  end

  def to_a
    @args.to_a
  end
end
