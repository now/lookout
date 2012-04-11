# -*- coding: utf-8 -*-

# Context in which expect blocks are evaluated.  Plug-ins may add private
# methods to this class to make them available to expect blocks.
class Lookout::Expect::Object::Context
  # @param [Object, …] *args Arguments to pass to _block_
  # @param [Proc] &block Expect block to evaluate inside the receiver
  def initialize(*args, &block)
    @args, @block = args, block
    @stubs = nil
  end

  # Evaluates the expect block inside the receiver.
  # @return [Object, nil] The result of the block, or nil if there is no block
  def evaluate
    instance_exec(*@args, &@block) if @block
  ensure
    @stubs.undefine if @stubs
  end

  private

  # @overload stub(methods = {})
  #   @param [Hash] methods
  #   @return [Lookout::Stub::Object] A stub object, set up with _methods_
  # @overload stub(object)
  #   @param [Object] object
  #   @return [Stub] A delayed wrapper that will set up a stub method on
  #     _object_
  def stub(object = {})
    case object
    when Hash
      Lookout::Stub::Object.new(object)
    else
      Stub.new(@stubs ||= Lookout::Stub::Methods.new, object)
    end
  end

  # Sets `$VERBOSE` to _verbose_ during the execution of the given block.
  # @param [true, false, nil] verbose
  # @yield
  # @return [Object] The result of the block
  def with_verbose(verbose = true)
    saved_verbose = $VERBOSE
    $VERBOSE = verbose
    begin
      yield
    ensure
      $VERBOSE = saved_verbose
    end
  end

  # Sets the constant identified by (the possibly qualified) _name_ to _value_
  # during the execution of the given block.  If _name_ is qualified, any
  # intermediate modules that aren’t defined will be set to new {Module}s.
  # These modules will be removed once the block returns.
  # @param [String] name
  # @param [Object] value
  # @return [Object] The result of the block
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
      missing.first.__send__(:remove_const, missing.last) if missing
    end
  end

  # Sets environment variables defined in _environment_ during the execution of
  # the given block.
  # @param [Hash] environment
  # @return [Object] The result of the block
  def with_environment(environment = {})
    saved = ENV.select{ |key, _| environment.include? key }
    saved = Hash[*saved.flatten] if RUBY_VERSION < '1.9'
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
