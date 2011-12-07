# -*- coding: utf-8 -*-

class Lookout::Expectations::Output < Lookout::Expectations::Object
  private

  def subject
    @output ||= StringIO.new
  end

  def check(actual)
    @output.rewind
    super(@expected.subject.class.new(@output.read))
  end
end
