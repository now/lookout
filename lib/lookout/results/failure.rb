# -*- coding: utf-8 -*-

class Lookout::Results::Failure
  include Lookout::Result

  def initialize(file, line, message)
    super file, line
    @message = message
  end

  def ==(other)
    super and message == other.message
  end

  def hash
    @hash ||= super ^ message.hash
  end

  def to_s
    [super, message].compact.join(': ')
  end

  attr_reader :message
end
