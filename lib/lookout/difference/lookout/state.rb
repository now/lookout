# -*- coding: utf-8 -*-

class Lookout::Difference::Lookout::State
  def initialize(message)
    @message = message
  end

  attr_reader :message

  def diff
    []
  end

  def ==(other)
    self.class == other.class and
      message == other.message
  end
end
