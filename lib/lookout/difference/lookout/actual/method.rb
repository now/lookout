# -*- coding: utf-8 -*-

class Lookout::Difference::Lookout::Actual::Method < Lookout::Difference::Object
  private

  def order
    [symbol, inspect_actual, inspect_expected]
  end

  def symbol
    '¬'
  end
end
