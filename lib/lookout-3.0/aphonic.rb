# -*- coding: utf-8 -*-

# Class that only responds to `#__send__` and #object_id.  Useful for DSLs and
# classes that make use of #method_missing.  Things are set
# up so that if methods are added to Kernel, Object, or Method after the
# initial set-up, such methods will similarly be {.silence}d.
class Lookout::Aphonic
  Methods = [:__send__, :object_id]
  Methods << :__id__ if RUBY_VERSION < '1.9' # Ruby 1.8 warns if __id__ is undefined

  class << self
    # Undefines METHOD unless it’s on the short-list of methods to keep.
    # @param [Symbol] method
    # @return [self]
    def silence(method)
      undef_method method if
        instance_methods.include?(RUBY_VERSION < '1.9' ? method.to_s : method.to_sym) and
        not Methods.include? method.to_sym
      self
    end
  end

  instance_methods.each(&method(:silence))
end

[Kernel, Object].each do |object|
  object.instance_eval{ class << self; self; end }.instance_eval do
    method_added = method(:method_added)
    define_method :method_added do |name|
      result = method_added.call(name)
      Lookout::Aphonic.silence name if self == object
      result
    end
  end
end

class Module
  append_features = instance_method(:append_features)
  define_method :append_features do |mod|
    result = append_features.bind(self).call(mod)
    instance_methods.each{ |name| Lookout::Aphonic.silence name } if mod == Object
    result
  end
end
