# -*- coding: utf-8 -*-

class Lookout::Results::Error::Exception
  def initialize(exception)
    @exception = exception
  end

  def ==(other)
    self.class == other.class and
      exception == other.exception
  end

  alias eql? ==

  def hash
    @hash ||= self.class.hash ^ exception.hash
  end

  def message
    # Chomping off a \n here isn’t 100 percent compatible with how Ruby 1.9
    # does it, but it simplifies the code and also makes the output better if
    # the message is a lone \n.
    message = (Lookout::Encode.new(String(exception.message)).call rescue '').chomp("\n")
    if exception_class == RuntimeError and message.empty?
      'unhandled exception'
    elsif message.empty?
      exception_class_name
    elsif exception_class_name.empty? or exception_class_name =~ /\A#/
      message
    else
      before, newline, after = message.partition("\n")
      '%s (%s)%s%s' % [before, exception_class_name, newline, after]
    end
  end

  def backtrace
    @backtrace ||= Backtrace.from(exception)
  end

  def to_s
    "%s\n%s" % [message, backtrace]
  end

  protected

  attr_reader :exception

  private

  def exception_class
    @exception_class ||= begin
                           exception.class
                         rescue
                           Exception
                         end
  end

  def exception_class_name
    @exception_class_name ||= begin
                                Lookout::Encode.new(exception_class.name).call
                              rescue => e
                                'cannot determine class name of exception: %s' %
                                  Lookout::Inspect::Error.new(e).call
                              end
  end
end
