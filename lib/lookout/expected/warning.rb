# -*- coding: utf-8 -*-

class Lookout::Expected::Warning < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Warning.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Output.new
  end
end
