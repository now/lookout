# -*- coding: utf-8 -*-

class Lookout::Aphonic
  def self.silence(name)
    undef_method name if
      instance_methods.include?(RUBY_VERSION < '1.9' ? name.to_s : name.to_sym) and
      name !~ /^(?:__|(?:instance_eval|extend|is_a\?|object_id)$)/
  end

  instance_methods.each do |name|
    silence name
  end
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
    instance_methods.each do |name|
      Lookout::Aphonic.silence name
    end if mod == Object
    result
  end
end
