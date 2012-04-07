# -*- coding: utf-8 -*-

class Lookout::Difference::Range < Lookout::Difference::Object
  private

  def symbol
    Range === actual ? super : '∉'
  end
end
