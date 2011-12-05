# -*- coding: utf-8 -*-

class Lookout::Expectations::Output < Lookout::Expectations::Object
  private

  def subject
    @output ||= StringIO.new
  end

  def check(actual)
    @output.rewind
    super(Lookout::Output.new(@output.read))
  end

  def equality
    @equality ||= Lookout::Equalities::Output.new
  end
end
