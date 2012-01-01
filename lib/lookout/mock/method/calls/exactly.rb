# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls::Exactly
  include Lookout::Mock::Method::Calls

  def initialize(limit)
    raise ArgumentError,
      'expected mock method invocation count must be non-negative: %d < 0' %
        limit if limit < 0
    super
  end

  def to_s
    '%d' % limit
  end

  private

  def satisfied?
    calls == limit
  end
end
