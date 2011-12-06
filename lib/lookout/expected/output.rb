# -*- coding: utf-8 -*-

class Lookout::Expected::Output < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Output.new(@expected, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Output.new
  end
end
