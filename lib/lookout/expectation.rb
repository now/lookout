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

  def evaluate
    Lookout::Stub.methods{ |@stubs| evaluate_with_stubs }.tap{ @stubs = nil }
  end

  def stub(*args)
    raise ArgumentError,
      'wrong number of arguments (%d for 1)' % args.length unless args.count < 2
    return Lookout::Stub::Object.new if args.length < 1
    case args[0]
    when Hash
      Lookout::Stub::Object.new.tap{ |stub|
        args[0].each do |name, value|
          @stubs.define(stub, name){ value }
        end
      }
    else
      Method.new(@stubs, args[0])
    end
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
    end
  end
end
