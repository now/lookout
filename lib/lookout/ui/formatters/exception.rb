# -*- coding: utf-8 -*-

class Lookout::UI::Formatters::Exception
  autoload :Backtrace, 'lookout/ui/formatters/exception/backtrace'

  def initialize(exception)
    @exception = exception
  end

  def message
    message = @exception.message.to_str
    if @exception.class == RuntimeError and message.empty?
      'unhandled exception'
    elsif message.empty?
      @exception.class.name
    elsif @exception.class.name.empty? or @exception.class.name =~ /^#/
      message
    else
      '%s (%s)' % [message.chomp("\n"), @exception.class.name]
    end
  end

  def backtrace
    @backtrace ||= Backtrace.new(@exception.backtrace)
  end

  def to_s
    "%s\n%s" % [message, backtrace]
  end
end
