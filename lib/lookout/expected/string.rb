# -*- coding: utf-8 -*-

class Lookout::Expected::String < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::String.new(@expected, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::String.new
  end
end
