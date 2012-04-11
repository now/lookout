# -*- coding: utf-8 -*-

# Represents expected values that are descendants of {::Exception}.
class Lookout::Expected::Classes::Exception < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Lookout::Expect::Classes::Exception] An expect block for the
  #   receiver
  def expect(file, line, &block)
    Lookout::Expect::Classes::Exception.new(self, file, line, &block)
  end
end
