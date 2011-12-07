# -*- coding: utf-8 -*-

class Lookout::Diff::Formats::Unified
  include Enumerable

  def initialize(groups)
    @groups = groups
  end

  def each
    return enum_for(__method__) unless block_given?
    @groups.each do |group|
      next if group.parity?
      yield Group.new(group).to_s
    end
    self
  end

  private

  class Group
    def initialize(group)
      @group = group
    end

    def delete(operation)
      mark('-', operation.from)
    end

    def equal(operation)
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

    def mark(mark, range)
      range.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
