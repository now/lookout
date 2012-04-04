# -*- coding: utf-8 -*-

# Represents a range that should be deleted from the original sequence.
class Lookout::Diff::Operations::Delete < Lookout::Diff::Operation
  # @param [Object] object
  # @return The result of _object_#delete(self)
  def apply(object)
    object.delete(self)
  end
end
