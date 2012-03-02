# -*- coding: utf-8 -*-

module Lookout::Mock::Method
  def ==(other)
    super and
      calls == other.calls and
      args == other.args
  end

  def to_s
    '%s%s%s' % [Lookout::Inspect.new(object, 'object').call,
                Class === object ? '.' : '#',
                method]
  end

  protected

  attr_reader :calls, :args
end
