# -*- coding: utf-8 -*-

module Lookout::Expectation
  def self.on(expected, file, line, &block)
    (expected.is_a?(Lookout::Recorder) ?
     Lookout::Expectations::Behavior :
     Lookout::Expectations::State).new(expected, file, line, &block)
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line.to_i, block
  end

  def execute
    Lookout::Stub.methods do |@stubs|
      execute_with_stubs
    end
    @stubs = nil
    self
  end

  def stub(*args)
    raise ArgumentError,
      'wrong number of arguments (%d for 1)' % args.length unless args.count < 2
    args.length > 0 ? Method.new(@stubs, args[0]) : Lookout::Stub::Object.new
  end

  attr_reader :file, :line

private

  class Method < Lookout::Aphonic
    undef extend
    undef is_a?

    def initialize(stubs, object)
      @stubs, @object = stubs, object
    end

    def method_missing(method, &body)
      @stubs.define(@object, method, &body)
      @object
    end
  end
end
