# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Lower < Lookout::Mock::Method::Calls
  format  1,  0, '%s didn’t receive #%s, expected at least once'
  format  2,  0, '%s didn’t receive #%s, expected at least twice'
  format  2,  1, '%s received #%s once, expected at least twice'
  format(-1,  0, '%s didn’t receive #%s, expected at least %d times')
  format(-1,  1, '%s received #%s once, expected at least %d times')
  format(-1,  2, '%s received #%s twice, expected at least %d times')
  format(-1,  -1, '%s received #%s %d times, expected at least %d times')

  def initialize(object, method, limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  private

  def surpassed?
    false
  end

  def satisfied?
    @calls >= @limit
  end
end
