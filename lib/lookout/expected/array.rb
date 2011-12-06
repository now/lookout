# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Array.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Array.new
  end
end
