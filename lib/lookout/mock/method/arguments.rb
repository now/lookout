# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments
  autoload :Any, 'lookout/mock/method/arguments/any'
  autoload :List, 'lookout/mock/method/arguments/list'
  autoload :None, 'lookout/mock/method/arguments/none'
  autoload :One, 'lookout/mock/method/arguments/one'

  Error = Class.new(Lookout::Mock::Error)

  def initialize(*expected)
    @expected = expected.empty? ? Any.new : List.new(expected)
  end

  def verify(*args)
    @expected == args or
      raise Error, 'unexpected arguments: (%s)≠(%s)' % [args.join(', '), @expected]
  end

  def to_s
    result = @expected.to_s
    result.empty? ? "" : '(%s)' % result
  end
end
