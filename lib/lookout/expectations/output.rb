# -*- coding: utf-8 -*-

class Lookout::Expectations::Output < Lookout::Expectations::Object
  private

  def subject
    @output ||= StringIO.new
  end

  def check(actual)
    super(@expected.subject.class.new(@output.string))
  end
end
