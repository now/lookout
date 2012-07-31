# -*- coding: utf-8 -*-

class Lookout::Reception::Error < StandardError
  class << self
    def from(reception, calls, range)
      new('%s: unexpected number of invocations (%d for %s)' %
          [reception,
           calls,
           if range.begin == range.end
             range.begin
           elsif range.end == 1.0/0
             '%d..' % range.begin
           else
             range
           end])
    end
  end
end
