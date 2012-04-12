# -*- coding: utf-8 -*-

# Base module for mock methods.
module Lookout::Mock::Method
  # @param (see Stub::Method#initialize)
  # @param [Calls] calls The expected number of calls that should be made
  # @param [Object, …] *args The expected arguments
  # @see Stub::Method#initialize
  # @see Stub::Method::Defined#initialize
  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls, Arguments.new(*args)
  end

  # @param [Lookout::Mock::Method] other
  # @return [Boolean] True if the receiver {Stub::Method#==}’s _other_ and the
  #   expected number of calls and expected arguments are also `#==`
  def ==(other)
    super and
      calls == other.calls and
      args == other.args
  end

  protected

  attr_reader :calls, :args
end
