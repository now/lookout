# -*- coding: utf-8 -*-

module Lookout::Mock::Method
  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls, Arguments.new(*args)
  end

  def ==(other)
    super and
      calls == other.calls and
      args == other.args
  end

  protected

  attr_reader :calls, :args
end
