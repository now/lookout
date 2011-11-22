# -*- coding: utf-8 -*-

module Lookout::Expectation
  def self.on(expected, file, line, &block)
    case expected
    when Lookout::Recorder
      Lookout::Expectations::Behavior
    when Lookout::Warning
      Lookout::Expectations::State::Warning
    else
      Lookout::Expectations::State
    end.new(expected, file, line, &block)
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  # TODO: Do this in separate context that only has stub, with_verbose and any
  # other extensions provided by external libraries.
  # TODO: This way we can also delay Lookout::Stub::Methods creation until stub is called.
  def evaluate
    Lookout::Stub.methods{ |stubs| @stubs = stubs; evaluate_with_stubs }.tap{ @stubs = nil }
  end

  def stub(*args)
    raise ArgumentError,
      'wrong number of arguments (%d for 1)' % args.length unless args.count < 2
    return Lookout::Stub::Object.new if args.length < 1
    case args[0]
    when Hash
      Lookout::Stub::Object.new.tap{ |stub|
        args[0].each do |name, value|
          if value.respond_to? :to_proc
            @stubs.define(stub, name, &value)
          else
            @stubs.define(stub, name){ value }
          end
        end
      }
    else
      Method.new(@stubs, args[0])
    end
  end

  def with_verbose(verbose = true)
    saved_verbose = $VERBOSE
    $VERBOSE = verbose
    begin
      yield
    ensure
      $VERBOSE = saved_verbose
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
