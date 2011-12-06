# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::State
  include Lookout::Expectation

  def evaluate
    Context.new(@expected.subject, &@block).evaluate
    begin
      @expected.verify
    rescue Lookout::Recorders::State::Error => e
      # TODO: Guard against e#message failing?
      return Lookout::Results::Failures::State.new(file, line, e.message)
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
