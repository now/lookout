# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Range.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Include.new
  end
end
