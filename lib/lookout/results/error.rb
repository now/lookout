# -*- coding: utf-8 -*-

class Lookout::Results::Error
  include Lookout::Result

  def initialize(file, line, message, exception)
    super file, line
    @message, @exception = message, Exception.new(exception)
  end

  def ==(other)
    super and message == other.message and exception == other.exception
  end

  attr_reader :message, :exception

  def to_s
    [super, message, exception].compact.join(': ')
  end
end
