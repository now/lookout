# -*- coding: utf-8 -*-

class Lookout::Exception
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
    @message ||= encode(begin
                          String(exception.message)
                        rescue => e
                          'cannot retrieve error message: %s' %
                            encode((String(e) rescue
                                    'and cannot retrieve error message for error that generated that error either; giving up'))
                        end)
  end

  def header
    # Chomping off a \n here isn’t 100 percent compatible with how Ruby 1.9
    # does it, but it simplifies the code and also makes the output better if
    # the message is a lone \n.
    message = (Lookout::Encode.new(String(exception.message)).call rescue '').chomp("\n")
    if RuntimeError == type and message.empty?
      'unhandled exception'
    elsif message.empty?
      type_name
    elsif type_name.empty? or type_name.start_with? '#'
      message
    else
      before, newline, after = message.partition("\n")
      '%s (%s)%s%s' % [before, type_name, newline, after]
    end
  end

  def backtrace
    @backtrace ||= Backtrace.from(exception)
  end

  def type
    @type ||= begin
                exception.class
              rescue => e
                Unknown.new(e)
              end
  end

  def type_name
    @type_name ||= begin
                      Lookout::Encode.new(type.name).call
                    rescue => e
                     'cannot determine name of class of exception: %s' %
                       self.class.new(e).message
                    end
  end

  def to_s
    "%s\n%s" % [header, backtrace]
  end

  protected

  attr_reader :exception

  private

  def encode(message)
    Lookout::Encode.new(message).call
  rescue => e
    'cannot encode error message for output: %s%s' %
      [(Lookout::Encode.new(String(e)).call rescue
        'and cannot encode error message for error that generated that error for output either; giving up'),
       ('; dumping instead: %s' % [message.dump] rescue '')]
  end
end
