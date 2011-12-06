# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Include.new
  end
end
