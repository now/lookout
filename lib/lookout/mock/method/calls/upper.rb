# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Upper < Lookout::Mock::Method::Calls
  format  1,  2, '%s received #%s twice, expected at most once'
  format  1, -1, '%s received #%s %d times, expected at most once'
  format  2, -1, '%s received #%s %d times, expected at most twice'
  format(-1, -1, '%s received #%s %d times, expected at most %d times')

  def initialize(object, method, limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  private

  def satisfied?
    @calls <= @limit
  end
end
