# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Upper < Lookout::Mock::Method::Calls
  format  1,  2, 'expected %s to be called at most once, but was called twice'
  format  1, -1, 'expected %s to be called at most once, but was called %d times'
  format  2, -1, 'expected %s to be called at most twice, but was called %d times'
  format(-1, -1, 'expected %s to be called at most %d times, but was called %d times')

  def initialize(limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  private

  def satisfied?
    @calls <= @limit
  end
end
