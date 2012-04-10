# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Classes::Exception}s.
class Lookout::Expect::Classes::Exception < Lookout::Expect::Object
  # Evaluates the expect block and checks the first raised Exception’s class
  # against the expected Exception class.  If no exception is raised, the
  # actual result is checked against the expected value.
  # @return [Lookout::Results::Error] If the exception’s class isn’t equal to
  #   or a descendant of the expected result class
  # @return [Lookout::Results::Success] If the exception’s class is equal to or
  #   a descendant of the expected result class
  # @return (see Object#check)
  def call
    begin
      result = evaluate_block
    rescue @expected.subject
      return Lookout::Results::Success.new(file, line)
    rescue Exception => e
      return Lookout::Results::Error.
        new(file,
            line,
            @expected.difference(Lookout::Exception.new(e).type).message,
            e)
    end
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
