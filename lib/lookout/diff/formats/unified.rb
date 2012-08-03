# -*- coding: utf-8 -*-

# Formats {Group}s in unified format.  This format shows {Groups} of related
# operations, providing a script of changes to be made that is both human and
# computer readable.  For more information, see
# {http://en.wikipedia.org/wiki/Diff#Unified_format}.
#
# This format is used by {Difference::String} for multi-line Strings.
class Lookout::Diff::Formats::Unified
  # Formats GROUPS in unified format.
  # @param [Groups] groups
  Value(:groups)
  include Enumerable

  # @overload
  #   Enumerates the formatted groups.
  #
  #   @yieldparam [String] string
  # @overload
  #   @return [Enumerator<String>] An Enumerator over the formatted groups
  def each
    return enum_for(__method__) unless block_given?
    groups.each do |group|
      next if group.parity?
      yield Group.new(group).to_s
    end
    self
  end

  # @return The concatenation of the formatted groups
  def to_s; to_a.join("\n") end

  private

  # @private
  class Group
    def initialize(group) @group = group end
    def delete(operation) mark('-', operation.old) end
    def copy(operation) mark(' ', operation.old) end
    def insert(operation) mark('+', operation.new) end
    def replace(operation) delete(operation).concat(insert(operation)) end

    def to_s
      lines = ['@@ -%d,%d +%d,%d @@' %
               [@group.old.begin + 1, @group.old.size,
                @group.new.begin + 1, @group.new.size]]
      @group.each do |operation|
        lines.concat operation.apply(self)
      end
      lines.join("\n")
    end

    private

    def mark(mark, slice) slice.map{ |item| [mark, item].join('') } end
  end
end
