# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Hash.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Hash.new
  end
end
