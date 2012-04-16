# -*- coding: utf-8 -*-

# Definition of a stub method.
class Lookout::Stub::Method::Defined::Definition
  # Saves the current definition of _method_ on _object_, if any, then replaces
  # it with _body_, maintaining its visibility.
  # @param [Object] object
  # @param [Symbol] method
  # @param [Proc] &body
  def initialize(object, method, &body)
    @object, @method = object, method
    @visibility, @unbound = meta_exec{
      visibility, methods =
        private_method_defined?(method) ? [:private, private_instance_methods(false)] :
        protected_method_defined?(method) ? [:protected, protected_instance_methods(false)] :
        public_method_defined?(method) ? [nil, instance_methods(false)] : [nil, []]
      unbound = methods.include?(RUBY_VERSION < '1.9' ? method.to_s : method) ?
        instance_method(method) : nil
      define_method method do |*args, &block|
        body.call(*args, &block)
      end
      send visibility, method if visibility
      [visibility, unbound]
    }
  end

  # Undefines the stub method, restoring the methods previous definition and
  # its visibility, if one existed.
  # @return [self]
  def undefine
    meta_exec method, visibility, unbound do |method, visibility, unbound|
      remove_method method
      if unbound
        define_method method, unbound
        send visibility, method if visibility
      end
    end
    self
  end

  # @return [Boolean] True if the receiver’s class, object, method name,
  #   visibility, and previous definition `#==` those of _other_
  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      visibility == other.visibility and
      unbound == other.unbound
  end

  protected

  attr_reader :object, :method, :visibility, :unbound

  private

  def meta_exec(*args, &block)
    (@meta ||= Kernel == object ? object : (class << object; self; end)).
      module_exec(*args, &block)
  end
end
