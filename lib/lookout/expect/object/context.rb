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
    when Symbol
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

  def with_constant(name, value)
    missing = nil
    parts = name.split('::')
    begin
      parent = parts[0..-2].reduce(Object){ |o, e|
        begin
          if RUBY_VERSION < '1.9'
            # This is racy, but unavoidable.
            raise NameError unless o.const_defined? e
            o.const_get(e)
          else
            o.const_get(e, false)
          end
        rescue NameError
          missing = [o, e] unless missing
          o.const_set(e, Module.new)
        end
      }
      saved = parent.const_get(parts.last) unless missing
      parent.const_set(parts.last, value)
      begin
        yield
      ensure
        parent.const_set(parts.last, saved) unless missing
      end
    ensure
      missing.first.__send__(:remove_const, missing.last)
    end
  end

  def with_environment(environment = {})
    saved = ENV.select{ |key, _| environment.include? key }
    missing = environment.reject{ |key, _| ENV.include? key }
    begin
      ENV.update environment
      yield
    ensure
      ENV.update saved
      ENV.delete_if{ |key, _| missing.include? key }
    end
  end
end
