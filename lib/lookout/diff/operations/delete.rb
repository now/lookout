# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Delete
  include Lookout::Diff::Operation

  def apply(object)
    object.delete(self)
  end
end
