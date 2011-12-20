# -*- coding: utf-8 -*-

class Lookout::Expect::Exception < Lookout::Expect::Object
  def call
    begin
      result = evaluate_block
    rescue Exception => actual
      # TODO: Guard against @expected#class, @expected#class#==, or actual#class failing.
      return @expected.subject.class == actual.class ?
        check(actual) :
        Lookout::Results::Error.
          new(file,
              line,
              @expected.subject.class.to_lookout_expected.message(actual.class),
              actual)
    end
    # TODO: Should we perhaps return an error if an error isn’t raised?  Do we
    # want to be able to return an error and verify that it’s returned?
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
