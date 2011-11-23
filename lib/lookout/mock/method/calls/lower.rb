# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Lower
  extend Lookout::Mock::Method::Calls::Class
  include Lookout::Mock::Method::Calls::Instance

  format  1,  0, 'expected %s to be called at least once'
  format  2,  0, 'expected %s to be called at least twice'
  format  2,  1, 'expected %s to be called at least twice, but was only called once'
  format(-1, -1, 'expected %s to be called at least %d times, but was only called %d times')

  def initialize(method, limit)
    raise ArgumentError, 'limit must be > 0' unless limit > 0
    super
  end

  private

  def satisfied?
    @calls >= @limit
  end
end
