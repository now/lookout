# -*- coding: utf-8 -*-

class Lookout::Expectations::Module < Lookout::Expectations::Object
  private

  def equality
    @equality ||= Lookout::Equalities::Include.new
  end
end
