# -*- coding: utf-8 -*-

class Lookout::Exception::Unknown
  def initialize(exception)
    @exception = exception
  end

  def name
    raise message
  end

  def inspect
    '(%s)' % message
  end

  private

  def message
    @message ||= 'cannot determine class of exception: %s' %
      Lookout::Exception.new(@exception).message
  end
end
