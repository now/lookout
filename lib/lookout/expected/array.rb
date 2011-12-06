# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Array.new
  end
end
