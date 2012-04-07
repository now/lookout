# -*- coding: utf-8 -*-

class Lookout::Difference::Module < Lookout::Difference::Object
  private

  def symbol
    Module === actual ? super : '≉'
  end
end
