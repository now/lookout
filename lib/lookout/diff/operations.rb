# -*- coding: utf-8 -*-

# Represents a sequence of {Operation}s based on a sequence of {Match}es.  Each
# match is turned into a {Copy}, {Delete}, {Insert}, or {Replace} operation
# based on its relation to other matches in the sequence of matches.  Empty
# copy operations will never be a part of this sequence.
class Lookout::Diff::Operations
  include Enumerable

  # @param [Matches] matches The matches to convert to operations
  def initialize(matches)
    @matches = matches
  end

  # @overload
  #   Enumerates the operations.
  #
  #   @yieldparam [Operation] operation
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the operations
  def each
    return enum_for(__method__) unless block_given?
    from = to = 0
    @matches.each do |match|
      type = typeify(from, to, match)
      yield type.new(match.from.at(from...match.from.begin),
                     match.to.at(to...match.to.begin)) unless type == Copy
      yield Copy.new(match.from, match.to) unless match.empty?
      from, to = match.from.end + 1, match.to.end + 1
    end
    self
  end

  private

  def typeify(from, to, match)
    if    from < match.from.begin and to < match.to.begin then Replace
    elsif from < match.from.begin                         then Delete
    elsif to < match.to.begin                             then Insert
    else                                                       Copy
    end
  end
end
