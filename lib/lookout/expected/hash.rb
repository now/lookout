# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Hash.new
  end
end
