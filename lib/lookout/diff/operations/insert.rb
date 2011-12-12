# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Insert < Lookout::Diff::Operation
  def apply(object)
    object.insert(self)
  end
end
