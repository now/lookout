# -*- coding: utf-8 -*-

# Formats {Operation}s on an undordered set.  Added subsequences are shown
# having each element prefixed by “+” and deleted subsequences by “-”.
# Replaced subsequences are shown as a deleted subsequence followed by an added
# subsequence.
#
# This format is used by {Difference::Hash}.
class Lookout::Diff::Formats::Set
  include Enumerable

  # Formats _operations_ as they would be applied to an unordered set.
  # @param [Operations] operations
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
    operations.each do |op|
      operation = Operation.new(op)
      yield operation.to_s unless operation.empty?
    end
    self
  end

  # @return [String] The concatenation of the formatted operations
  def to_s
    to_a.join("\n")
  end

  # @param [Inline] other
  # @return [Boolean] True if the receiver’s class and operations `#==` those
  #   of _other_
  def ==(other)
    self.class == other.class and operations == other.operations
  end

  alias eql? ==

  def hash
    operations.hash
  end

  protected

  attr_reader :operations

  private

  class Operation
    def initialize(operation)
      @lines = operation.apply(self)
    end

    def empty?
      @lines.nil?
    end

    def delete(operation)
      mark('-', operation.old)
    end

    def copy(operation)
    end

    def insert(operation)
      mark('+', operation.new)
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @lines.join("\n")
    end

    private

    def mark(mark, slice)
      slice.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
