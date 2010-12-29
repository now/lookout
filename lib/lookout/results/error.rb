# -*- coding: utf-8 -*-

class Lookout::Results::Error < Lookout::Result
  is :error

  def initialize(file, line, message, exception)
    super file, line
    @message, @exception = message, exception
  end

  attr_reader :message, :exception
end
