# -*- coding: utf-8 -*-

# Provides non-failing access to some of {::Exception}’s methods.  Used in
# subsystems where unhandled failure isn’t an option, such as {Inspect} and
# {Results::Error}.  Also uses {Encode} so that all strings are ready for
# output.
class Lookout::Exception
  # Provides non-failing access to _exception_’s message, backtrace, and type.
  # @param [::Exception] exception
  Value(:exception)

  # @return [String] The UTF-8-encoded exception message or the UTF-8-encoded
  #   exception message of any exception that was raised while trying to retrieve
  #   it
  def message
    @message ||= encode(begin
                          String(exception.message)
                        rescue => e
                          'cannot retrieve error message: %s' %
                            encode((String(e) rescue
                                    'and cannot retrieve error message for error that generated that error either; giving up'))
                        end)
  end

  alias to_s message

  # @return [String] A heuristically generated UTF-8-encoded exception message
  #   “header”, possibly containing the exception message and the exception’s
  #   class’ name
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

  # @return [Backtrace] A non-failing backtrace wrapper of the exception
  #   backtrace
  def backtrace
    @backtrace ||= Backtrace.from(exception)
  end

  # @return [#name, #inspect] Either the exception’s class or an {Unknown}
  #   wrapper around the exception that was raised while trying to determine
  #   the class
  def type
    @type ||= begin exception.class; rescue => e; Unknown.new(e) end
  end

  # @return [String] The UTF-8-encoded name of the exception’s class
  def type_name
    @type_name ||= begin
                      Lookout::Encode.new(type.name).call
                    rescue => e
                     'cannot determine name of class of exception: %s' %
                       self.class.new(e)
                    end
  end

  # @return [String] The {#header} and {#backtrace} separated by a newline
  def format
    "%s\n%s" % [header, backtrace]
  end

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
