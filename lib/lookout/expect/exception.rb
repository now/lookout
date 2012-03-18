# -*- coding: utf-8 -*-

class Lookout::Expect::Exception < Lookout::Expect::Object
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
