# -*- coding: utf-8 -*-

class Lookout::Expected::Boolean < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Boolean.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Boolean.new
  end
end
