# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  Error = Class.new(Lookout::Mock::Error)

  def initialize(*args)
    @args = if args.empty? then Any.new
            elsif any = args.find{ |e| Any === e } then any
            elsif none = args.find{ |e| None === e } then none
            else List.new(*args)
            end
  end

  def verify(*args)
    self.args =~ args or
      raise Error, 'unexpected arguments ([%s]≠[%s])' % [List.new(*args), self.args]
  end

  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      args == other.args
  end

  alias eql? ==

  def hash
    self.class.hash ^ object.hash ^ method.hash ^ args.hash
  end

  def to_s
    (result = args.to_s).empty? ? result : '(%s)' % result
  end

  def to_a
    args.to_a
  end

  protected

  attr_reader :object, :method, :args
end
