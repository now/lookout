# -*- coding: utf-8 -*-

class Lookout::Expectations::Boolean < Lookout::Expectations::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Boolean.new
  end
end
