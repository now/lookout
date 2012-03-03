# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Defined < Lookout::Stub::Method::Defined
  include Lookout::Mock::Method

  def undefine
    definition.undefine
    calls.verify
    Undefined.new(object, method, calls, *args, &body)
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  private

  def call(*args, &block)
    calls.call
    self.args.verify(*args)
    super
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end
end
