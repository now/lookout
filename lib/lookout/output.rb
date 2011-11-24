# -*- coding: utf-8 -*-

class Lookout::Output < StringIO
  def initialize(expected)
    @expected = expected
    super()
  end

  attr_reader :expected

  def actual
    rewind
    @actual ||= read
  end

  def inspect
    'output(%p)' % expected
  end
end
