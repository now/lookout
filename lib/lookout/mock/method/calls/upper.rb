# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Upper
  extend Lookout::Mock::Method::Calls::Class
  include Lookout::Mock::Method::Calls::Instance

  format  1,  2, 'expected %s to be called at most once, but was called twice'
  format  1, -1, 'expected %s to be called at most once, but was called %d times'
  format  2, -1, 'expected %s to be called at most twice, but was called %d times'
  format -1, -1, 'expected %s to be called at most %d times, but was called %d times'

  def initialize(method, limit)
    raise ArgumentError, 'limit must be > 0' unless limit > 0
    super
  end

private

  def satisfied?
    @calls <= @limit
  end
end
