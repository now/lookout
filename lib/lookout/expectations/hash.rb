# -*- coding: utf-8 -*-

class Lookout::Expectations::Hash < Lookout::Expectations::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Hash.new
  end
end
