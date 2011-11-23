# -*- coding: utf-8 -*-

class Lookout::Equalities::Hash < Lookout::Equalities::Object
  Lookout::Equality.register self, Hash

  def equal?(expected, actual)
    return false unless Hash === actual and expected.size == actual.size
    expected.all?{ |k, v| Lookout::Equality.equal? v, actual[k] }
  end

  def diff(expected, actual)
    return if expected.size == 1 or not Hash === actual
    Lookout::Diff::Formats::Hash.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.
                  new(array(actual), array(expected)))).to_a.join("\n")
  end

  private

  def array(hash)
    hash.to_a.sort_by{ |k, v| k }.map{ |k, v| '%p => %p' % [k, v] }
  end
end

