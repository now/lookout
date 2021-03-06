# -*- coding: utf-8 -*-

# Difference reports between {::Hash}es.  These reports are generated by
# turning the Hashes into {::Array}s, sorting them by key, and finally mapping
# the keys and values to their String inspections.
class Lookout::Difference::Hash < Lookout::Difference::Object
  # @return [Lookout::Diff::Formats::Set, super] A set “diff” unless
  #   {#expected} contains one element or {#actual} isn’t a Hash, {super}
  #   otherwise
  def diff
    return super if expected.size == 1 or not Hash === actual
    Lookout::Diff::Formats::Set.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.
                  new(array(actual), array(expected))))
  end

  private

  # @return [::String, super] The symbol ‘≉’ if {#actual} is a Hash of the
  #   same #size as {#expected}, {super} otherwise
  def symbol; Hash === actual && expected.size == actual.size ? '≉' : super end

  def array(hash)
    hash.to_a.sort_by{ |key, _| key }.map{ |key, value|
      [Lookout::Inspect.new(key, 'key'),
       ' => ',
       Lookout::Inspect.new(value, 'value')].join('')
    }
  end
end
