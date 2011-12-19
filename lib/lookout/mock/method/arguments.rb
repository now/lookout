# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  Error = Class.new(Lookout::Mock::Error)

  def initialize(*args)
    @args = if args.empty? then Any.new
            elsif none = args.find{ |e| None === e } then none
            else List.new(*args)
            end
  end

  def verify(*args)
    @args =~ args or
      raise Error, 'unexpected arguments: (%p)≠(%p)' % [List.new(*args), @args]
  end

  def inspect
    (result = @args.inspect).empty? ? result : '(%s)' % result
  end

  def to_a
    @args.to_a
  end
end
