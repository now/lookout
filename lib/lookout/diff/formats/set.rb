# -*- coding: utf-8 -*-

# Formats {Operation}s on an undordered set.  This is used by
# {Difference::Hash}.  Added ranges of elements are shown having each element
# prefixed by “+” and deleted ranges of elements by “-”.  Replaced ranges are
# shown as a deleted range followed by an added range.
class Lookout::Diff::Formats::Set
  include Enumerable

  # @param [Operations] operations Operations to format
  def initialize(operations)
    @operations = operations
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
    @operations.each do |op|
      operation = Operation.new(op)
      yield operation.to_s unless operation.empty?
    end
    self
  end

  # @return [String] The concatenation of the formatted operations
  def to_s
    to_a.join("\n")
  end

  private

  # @private
  class Operation
    def initialize(operation)
      @lines = operation.apply(self)
    end

    def empty?
      @lines.nil?
    end

    def delete(operation)
      mark('-', operation.from)
    end

    def equal(operation)
    end

    def insert(operation)
      mark('+', operation.to)
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @lines.join("\n")
    end

    private

    def mark(mark, range)
      range.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
