# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Replace
  include Lookout::Diff::Operation

  def apply(object)
    object.replace(self)
  end
end
