# -*- coding: utf-8 -*-

class Lookout::Expectations::Classes::StandardError < Lookout::Expectations::Object
  def evaluate
    begin
      # TODO: Should we perhaps return an error if an error isn’t raised?  Do we
      # want to be able to return an error and verify that it’s returned?
      check(@block ? Context.new(subject, &@block).evaluate : false)
    rescue @expected
      Lookout::Results::Fulfilled.new(file, line)
    rescue Exception => e
      # TODO: Guard against failing actual#class?
      Lookout::Results::Error.new(file, line, equality.message(@expected, e.class), e)
    end
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
