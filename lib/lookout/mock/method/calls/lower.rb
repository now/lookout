# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Lower < Lookout::Mock::Method::Calls
  format  1,  0, 'expected %s to be called at least once'
  format  2,  0, 'expected %s to be called at least twice'
  format  2,  1, 'expected %s to be called at least twice, but was only called once'
  format(-1,  0, 'expected %s to be called at least %d times')
  format(-1,  1, 'expected %s to be called at least %d times, but was only called once')
  format(-1,  2, 'expected %s to be called at least %d times, but was only called twice')
  format(-1, -1, 'expected %s to be called at least %d times, but was only called %d times')

  def initialize(method, limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  private

  def satisfied?
    @calls >= @limit
  end
end
