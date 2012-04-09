# -*- coding: utf-8 -*-

# Generates difference reports between {::Hash}es.  These differences are done
# by turning the Hashes into {::Array}s, sorting them by key, and finally
# mapping the keys and values to their String inspections.
class Lookout::Difference::Hash < Lookout::Difference::Object
  # @return [Lookout::Diff::Formats::Set] A set “diff” unless {#expected}
  #   contains one element or {#actual} isn’t a Hash
  # @extension
  def diff
    return super if expected.size == 1 or not Hash === actual
    Lookout::Diff::Formats::Set.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.
                  new(array(actual), array(expected))))
  end

  private

  def array(hash)
    hash.to_a.sort_by{ |key, _| key }.map{ |key, value|
      '%s => %s' %
        [Lookout::Inspect.new(key, 'key').call,
         Lookout::Inspect.new(value, 'value').call]
    }
  end
end
