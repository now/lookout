# -*- coding: utf-8 -*-

# Represents expected values that are descendants of {::Exception}.
class Lookout::Expected::Classes::Exception < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam [Class] class
  # @yieldreturn [Class]
  # @return [Expect::Classes::Exception] An expect block for the receiver at
  #   _line_ in _file_ that’ll yield the {#expected} exception class and expect
  #   it or one of its descendants to be raised
  def expect(file, line, &block)
    Lookout::Expect::Classes::Exception.new(self, file, line, &block)
  end
end
