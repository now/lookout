# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Defined < Lookout::Stub::Method::Defined
  include Lookout::Mock::Method

  def call(*args, &block)
    @calls.call
    @args.verify(*args)
    super
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  def verify
    @calls.verify
    self
  end

  private

  def undefined
    Undefined.new(@object, @method, @calls, *@args, &@body)
  end
end
