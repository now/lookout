# -*- coding: utf-8 -*-

module Lookout::Mock::Method
  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls, Arguments.new(object, method, *args)
  end

  def ==(other)
    super and
      calls == other.calls and
      args == other.args
  end

  def to_s
    '%s#%s' % [Lookout::Inspect.new(object, 'object').call, method]
  end

  protected

  attr_reader :calls, :args

  private

  def stash
    :"__mocked_method_#{method}"
  end
end
