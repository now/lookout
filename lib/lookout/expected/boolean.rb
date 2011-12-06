# -*- coding: utf-8 -*-

class Lookout::Expected::Boolean < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Boolean.new
  end
end
