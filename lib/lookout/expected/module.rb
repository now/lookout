# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Module.new(self, file, line, &block)
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Include.new
  end
end
