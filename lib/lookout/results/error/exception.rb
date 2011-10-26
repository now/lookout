# -*- coding: utf-8 -*-

class Lookout::Results::Error::Exception
  def initialize(exception)
    @exception = exception
  end

  def message
    # Chomping off a \n here isn’t 100 percent compatible with how Ruby 1.9
    # does it, but it simplifies the code and also makes the output better if
    # the message is a lone \n.
    message = @exception.message.to_str.chomp("\n")
    if @exception.class == RuntimeError and message.empty?
      'unhandled exception'
    elsif message.empty?
      @exception.class.name
    elsif @exception.class.name.empty? or @exception.class.name =~ /^#/
      message
    else
      before, newline, after = message.partition("\n")
      '%s (%s)%s%s' % [before, @exception.class.name, newline, after]
    end
  end

  def backtrace
    @backtrace ||= Backtrace.new(@exception.backtrace, SystemStackError === @exception)
  end

  def to_s
    "%s\n%s" % [message, backtrace]
  end
end
