# -*- coding: utf-8 -*-

# Represents a range of the original sequence that should be replaced with one
# of the new sequence.
class Lookout::Diff::Operations::Replace < Lookout::Diff::Operation
  # @param [Object] object
  # @return The result of _object_#replace(self)
  def apply(object)
    object.replace(self)
  end
end
