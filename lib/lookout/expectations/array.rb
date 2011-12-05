# -*- coding: utf-8 -*-

class Lookout::Expectations::Array < Lookout::Expectations::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Array.new
  end
end
