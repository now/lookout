# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Delete < Lookout::Diff::Operation
  def apply(object)
    object.delete(self)
  end
end
