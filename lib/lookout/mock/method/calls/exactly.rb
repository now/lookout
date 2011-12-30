# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Exactly
  include Lookout::Mock::Method::Calls
  def initialize(object, method, limit)
    raise ArgumentError, 'limit must be non-negative: %d < 0' % limit if limit < 0
    super
  end

  private

  def satisfied?
    calls == limit
  end

  def operator
    '='
  end

  def negation
    '≠'
  end
end
