# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Include.new
  end
end
