# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Lower
  include Lookout::Mock::Method::Calls
  def initialize(limit)
    raise ArgumentError, 'limit must be positive: %d < 1' % limit if limit < 1
    super
  end

  private

  def surpassed?
    false
  end

  def satisfied?
    calls >= limit
  end

  def operator
    '≥'
  end

  def negation
    '<'
  end
end
