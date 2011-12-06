# -*- coding: utf-8 -*-

class Lookout::Expected::String < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::String.new
  end
end
