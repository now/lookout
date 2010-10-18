# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Exactly
  extend Lookout::Mock::Method::Calls::Class
  include Lookout::Mock::Method::Calls::Instance

  format  0,  1, 'expected %s not to be called'
  format  0,  2, 'expected %s not to be called, but was called twice'
  format  0, -1, 'expected %s not to be called, but was called %d times'
  format  1,  0, 'expected %s to be called'
  format  1,  2, 'expected %s to be called once, not twice'
  format  1, -1, 'expected %s to be called once, not %d times'
  format  2,  0, 'expected %s to be called twice'
  format  2,  1, 'expected %s to be called twice, but was only called once'
  format  2, -1, 'expected %s to be called twice, not %d times'
  format(-1, -1, 'expected %s to be called %d times, not %d times')

  def initialize(method, limit)
    raise ArgumentError, 'limit must be >= 0' unless limit >= 0
    super
  end

private

  def satisfied?
    @calls == @limit
  end
end
