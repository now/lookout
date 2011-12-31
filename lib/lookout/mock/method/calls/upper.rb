# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Upper
  include Lookout::Mock::Method::Calls

  def initialize(limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  def to_s
    '0..%d' % limit
  end

  private

  def satisfied?
    true
  end
end
