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

  def stub(object = {})
    case object
    when Hash
      Lookout::Stub::Object.new(object)
    else
      Stub.new(@stubs ||= Lookout::Stub::Methods.new, object)
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
