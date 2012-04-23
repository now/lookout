# -*- coding: utf-8 -*-

# Expect block of {Expected::Exception}s.
class Lookout::Expect::Exception < Lookout::Expect::Object
  # Evaluates the expect block and checks the first raised Exception against
  # the expected Exception.  If no exception is raised, the actual result is
  # checked against the expected value.
  # @return [Results::Error] If the raised exception isn’t of the same class as
  #   that of the expected result
  # @return (see Object#check)
  def call
    begin
      result = evaluate_block
    rescue Exception => actual
      exception = Lookout::Exception.new(actual)
      expected_class = expected.expected.class rescue Exception
      actual_class = exception.type
      return ((expected_class == actual_class) rescue false) ?
        check(actual) :
        Lookout::Results::Error.
          new(file,
              line,
              expected_class.to_lookout_expected.difference(actual_class).message,
              exception)
    end
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, Lookout::Exception.new(e))
  end
end
