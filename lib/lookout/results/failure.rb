# -*- coding: utf-8 -*-

class Lookout::Results::Failure < Lookout::Result
  is :failure

  def initialize(file, line, message)
    super file, line
    @message = message
  end

  attr_reader :message

  def to_s
    [super, message].compact.join(': ')
  end
end
