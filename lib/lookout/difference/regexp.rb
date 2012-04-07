# -*- coding: utf-8 -*-

class Lookout::Difference::Regexp < Lookout::Difference::Object
  private

  def symbol
    Regexp === actual ? super : '≉'
  end
end
