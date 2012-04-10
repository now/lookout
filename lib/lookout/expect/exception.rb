# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Exception}s.
class Lookout::Expect::Exception < Lookout::Expect::Object
  # Evaluates the expect block and checks the first raised Exception against
  # the expected Exception.  If no exception is raised, the actual result is
  # checked against the expected value.
  # @return [Lookout::Results::Error] If the exception isn’t of the same class
  #   as that of the expected result
  # @return (see Object#check)
  def call
    begin
      result = evaluate_block
    rescue Exception => actual
      expected_class = @expected.subject.class rescue Exception
      actual_class = Lookout::Exception.new(actual).type
      return ((expected_class == actual_class) rescue false) ?
        check(actual) :
        Lookout::Results::Error.
          new(file,
              line,
              expected_class.to_lookout_expected.difference(actual_class).message,
              actual)
    end
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
