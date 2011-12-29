# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Exactly < Lookout::Mock::Method::Calls
  format  0,  1, '%s received unexpected #%s'
  format  0,  2, '%s received unexpected #%s twice'
  format  0, -1, '%s received unexpected #%s %d times'
  format  1,  0, '%s didn’t receive #%s'
  format  1,  2, '%s received #%s twice, expected once'
  format  1, -1, '%s received #%s %d times, expected once'
  format  2,  0, '%s didn’t receive #%s, expected twice'
  format  2,  1, '%s received #%s once, expected twice'
  format  2, -1, '%s received #%s %d times, expected twice'
  format(-1,  0, '%s didn’t receive #%s, expected %d times')
  format(-1,  1, '%s received #%s once, expected %d times')
  format(-1,  2, '%s received #%s twice, expected %d times')
  format(-1, -1, '%s received #%s %d times, expected %d times')

  def initialize(limit)
    raise ArgumentError, 'limit must be non-negative: %d < 0' % limit if limit < 0
    super
  end

  private

  def satisfied?
    @calls == @limit
  end
end
