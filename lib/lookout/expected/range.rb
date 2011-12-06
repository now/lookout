# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Range.new(@expected, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Range.new
  end
end
