# -*- coding: utf-8 -*-

class Lookout::Expectation::Context
  def initialize(*args, &block)
    @args, @block = args, block
    @stubs = nil
  end

  def evaluate
    instance_exec(*@args, &@block).tap{ @stubs.undefine if @stubs }
  end

  def stub(*args)
    raise ArgumentError,
    'wrong number of arguments (%d for 1)' % args.length unless args.count < 2
    return Lookout::Stub::Object.new if args.length < 1
    @stubs = Lookout::Stub::Methods.new
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

  private

  class Method < Lookout::Aphonic
    undef extend

    def initialize(stubs, object)
      @stubs, @object = stubs, object
    end

    def method_missing(method, &body)
      @stubs.define(@object, method, &body)
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
end
