# -*- coding: utf-8 -*-

# Formats {Operation}s inline in a String.  Additions are shown as `{+…+}` and
# deletions as `[-…-]`.  Replacements are shown as a deletion followed by an
# insertion.
#
# This format is used by {Difference::String} for single-line Strings.
#
# This format is inspired by the plain word “diff” format used by
# [Git](http://git-scm.com/).  That format was surely inspired by something
# before it, but it’s where I first saw it, so that’s what I’m referencing.
class Lookout::Diff::Formats::Inline
  include Enumerable

  # Formats _operations_ as they would be applied inline on a String.
  # @param [Operations] operations
  def initialize(operations)
    @to_s = ToS.new(operations).to_s
  end

  # @overload
  #   Enumerates the formatted operations.
  #
  #   @yieldparam [String] string
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the formatted operations
  def each
    return enum_for(__method__) unless block_given?
    yield to_s
    self
  end

  # @return [String] The concatenation of the formatted operations
  def to_s
    @to_s
  end

  private

  class ToS
    def initialize(operations)
      @to_s = operations.map{ |o| o.apply(self) }.join('').freeze
    end

    def delete(operation)
      '[-%s-]' % operation.old.to_items
    end

    def copy(operation)
      operation.old.to_items
    end

    def insert(operation)
      '{+%s+}' % operation.new.to_items
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @to_s
    end
  end
end
