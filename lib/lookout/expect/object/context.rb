# -*- coding: utf-8 -*-

# Context in which expect blocks are evaluated.  Plug-ins may add private
# methods to this class to make them available to expect blocks.
class Lookout::Expect::Object::Context
  # Evaluates _block_ inside this context, passing _args_ to it, when
  #   {#evaluate}d.
  # @param [::Object, …] args
  def initialize(*args, &block)
    @args, @block = args, block
  end

  # @return [::Object, nil] The result of evaluating the block or nil if there’s
  #   no block
  def evaluate
    instance_exec(*@args, &@block) if @block
  end

  private

  # @overload stub(object, methods)
  #   Sets up stubs for each method name key in _methods_ to its value
  #   definition during the execution of the given block.  If the value of the
  #   key is a Proc it’ll be used as the method definition.  Otherwise, the
  #   method definition will be set up to return the value.
  #   @param [::Object] object
  #   @param [Hash<Symbol,Object>] methods
  #   @yieldparam [::Object] object
  #   @return [::Object] The result of the block
  # @overload stub(methods = {})
  #   @param [Hash<Symbol,::Object>] methods
  #   @return [Lookout::Stub::Object] A stub object set up with _methods_
  def stub(object = {}, methods = nil)
    return Lookout::Stub.new(object) unless methods
    recursion = proc{ |ms|
      return yield(object) if ms.empty?
      name, value = ms[0].first.to_sym, ms[0].last
      (Kernel == object ? object : (class << object; self; end)).module_exec{
        visibility, own =
          private_method_defined?(name) ? [:private, private_instance_methods(false)] :
          protected_method_defined?(name) ? [:protected, protected_instance_methods(false)] :
          public_method_defined?(name) ? [nil, instance_methods(false)] : [nil, []]
        unbound = own.include?(RUBY_VERSION < '1.9' ? name.to_s : name) ?
          instance_method(name) : nil
        Lookout::Stub.define self, name, value
        send visibility, name if visibility
        begin
          recursion.call(ms[1..-1])
        ensure
          remove_method name
          if unbound
            define_method name, unbound
            send visibility, name if visibility
          end
        end
      }
    }
    recursion.call(methods.to_a)
  end

  # Sets `$VERBOSE` to _verbose_ during the execution of the given block.
  # @param [true, false, nil] verbose
  # @yield
  # @return [::Object] The result of the block
  def with_verbose(verbose = true)
    saved = $VERBOSE
    $VERBOSE = verbose
    begin
      yield
    ensure
      $VERBOSE = saved
    end
  end

  # Sets the constant identified by (the possibly qualified) _name_ to _value_
  # during the execution of the given block.  If _name_ is qualified, any
  # intermediate modules that aren’t defined will be set to new {Module}s.
  # These modules will be removed once the block returns.
  # @param [String] name
  # @param [::Object] value
  # @return [::Object] The result of the block
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
  # @return [::Object] The result of the block
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
