# -*- coding: utf-8 -*-

class Lookout::Expect::Object::Context
  def initialize(*args, &block)
    @args, @block = args, block
    @stubs = nil
  end

  def evaluate
    instance_exec(*@args, &@block) if @block
  ensure
    @stubs.undefine if @stubs
  end

  private

  def stub(object = (default = true; nil))
    return Lookout::Stub::Object.new if default
    @stubs = Lookout::Stub::Methods.new unless @stubs
    case object
    when Hash
      Lookout::Stub::Object.new.tap{ |stub|
        object.each do |name, value|
          if Proc === value
            @stubs.define(stub, name, &value)
          else
            @stubs.define(stub, name){ value }
          end
        end
      }
    else
      Stub.new(@stubs, object)
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
