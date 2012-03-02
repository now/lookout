# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Defined < Lookout::Stub::Method::Defined
  include Lookout::Mock::Method

  def initialize(object, method, visibility, unbound, calls, *args, &body)
    super object, method, visibility, unbound, &body
    @calls, @args = calls, Arguments.new(*args)
  end

  def call(*args, &block)
    calls.call
    self.args.verify(*args)
    super
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  def undefine
    super.tap{ calls.verify }
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  private

  def undefined
    Undefined.new(object, method, calls, *args, &body)
  end
end
