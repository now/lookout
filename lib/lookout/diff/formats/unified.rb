# -*- coding: utf-8 -*-

# Formats {Group}s in unified format, see
# {http://en.wikipedia.org/wiki/Diff#Unified_format}.
#
# This format is used by {String} for multi-line Strings.
class Lookout::Diff::Formats::Unified
  include Enumerable

  # @param [Groups] groups Groups to format
  def initialize(groups)
    @groups = groups
  end

  # @overload
  #   Enumerates the formatted groups.
  #
  #   @yieldparam [String] string
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the formatted groups
  def each
    return enum_for(__method__) unless block_given?
    @groups.each do |group|
      next if group.parity?
      yield Group.new(group).to_s
    end
    self
  end

  # @return [String] The concatenation of the formatted groups
  def to_s
    to_a.join("\n")
  end

  private

  # @private
  class Group
    def initialize(group)
      @group = group
    end

    def delete(operation)
      mark('-', operation.from)
    end

    def copy(operation)
      mark(' ', operation.from)
    end

    def insert(operation)
      mark('+', operation.to)
    end

    def replace(operation)
      delete(operation).concat(insert(operation))
    end

    def to_s
      lines = ['@@ -%d,%d +%d,%d @@' %
               [@group.from.begin + 1, @group.from.size,
                @group.to.begin + 1, @group.to.size]]
      @group.each do |operation|
        lines.concat operation.apply(self)
      end
      lines.join("\n")
    end

    private

    def mark(mark, slice)
      slice.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
