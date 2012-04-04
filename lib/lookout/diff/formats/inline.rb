# -*- coding: utf-8 -*-

# Formats {Operation}s inline in a String.  Additions are shown as `{+…+}` and
# deletions as `[-…-]`.  Replacements are shown as a deletion followed by an
# insertion.
#
# This format is used by {Difference::String} for single-line Strings.
class Lookout::Diff::Formats::Inline
  include Enumerable

  # @param [Operations] operations Operations to format
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

  # @private
  class ToS
    def initialize(operations)
      @to_s = operations.map{ |o| o.apply(self) }.join('').freeze
    end

    def delete(operation)
      '[-%s-]' % operation.from.to_items
    end

    def equal(operation)
      operation.from.to_items
    end

    def insert(operation)
      '{+%s+}' % operation.to.to_items
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @to_s
    end
  end
end
