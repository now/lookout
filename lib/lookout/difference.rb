# -*- coding: utf-8 -*-

class Lookout::Difference
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

  alias eql? ==

  def hash
    self.class.hash ^ message.hash
  end
end
