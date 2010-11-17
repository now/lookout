# -*- coding: utf-8 -*-

require 'stringio'

class Lookout::IO < StringIO
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
    'io(%p)' % expected
  end
end
