# -*- coding: utf-8 -*-

class Lookout::Expectations::State::Output < Lookout::Expectations::State
  private

  def subject
    @output ||= StringIO.new
  end

  def check(actual)
    @output.rewind
    super(Lookout::Output.new(@output.read))
  end
end
