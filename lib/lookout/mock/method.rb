# -*- coding: utf-8 -*-

# Base module for mock methods.
module Lookout::Mock::Method
  # Prepares the mock _method_ on _object_, expecting it to be received _calls_
  # times with _args_ and using _body_ as the method definition.
  # @param (see Stub::Method#initialize)
  # @param [Calls] calls
  # @param [Object, …] args
  # @see Stub::Method::Defined#initialize
  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls, Arguments.new(*args)
  end

  def ==(other) super and calls == other.calls and args == other.args end
  alias eql? ==
  def hash; @hash ||= super ^ [calls, args].hash end

  protected

  attr_reader :calls, :args
end
