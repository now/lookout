# -*- coding: utf-8 -*-

class Lookout::Expectations::String < Lookout::Expectations::Object
  private

  def equality
    @equality ||= Lookout::Equalities::String.new
  end
end
