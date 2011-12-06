# -*- coding: utf-8 -*-

class Lookout::Expectations::StandardError < Lookout::Expectations::Object
  def evaluate
    begin
      # TODO: Should we perhaps return an error if an error isn’t raised?  Do we
      # want to be able to return an error and verify that it’s returned?
      check(@block ? Context.new(subject, &@block).evaluate : false)
    rescue Exception => actual
      # TODO: Guard against @expected#class, @expected#class#==, or actual#class failing.
      return check(actual) if subject.class == actual.class
      Lookout::Results::Error.
        new(file,
            line,
            Lookout::Equalities::Object.new.message(subject.class,
                                                    actual.class),
            actual)
    end
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::StandardError.new
  end
end
