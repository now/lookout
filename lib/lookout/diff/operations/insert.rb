# -*- coding: utf-8 -*-

# Represents a range that should be inserted from the new sequence.
class Lookout::Diff::Operations::Insert < Lookout::Diff::Operation
  # @param [Object] object
  # @return The result of _object_#insert(self)
  def apply(object)
    object.insert(self)
  end
end
