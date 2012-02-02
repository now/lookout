# -*- coding: utf-8 -*-

class Lookout::Expect::Classes::Exception < Lookout::Expect::Object
  def call
    begin
      result = evaluate_block
    rescue @expected.subject
      return Lookout::Results::Success.new(file, line)
    rescue Exception => e
      # TODO: Guard against failing e#class?
      return Lookout::Results::Error.new(file, line, @expected.difference(e.class).message, e)
    end
    # TODO: Should we perhaps return an error if an error isn’t raised?  Do we
    # want to be able to return an error and verify that it’s returned?
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
