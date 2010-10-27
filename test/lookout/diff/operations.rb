# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [] do
    Lookout::Diff::Operations.diff('', '').to_a
  end

  expect [Lookout::Diff::Operations::Delete.new(0...1, 0...0),
          Lookout::Diff::Operations::Equal.new(1...3, 0...2),
          Lookout::Diff::Operations::Replace.new(3...4, 2...3),
          Lookout::Diff::Operations::Equal.new(4...6, 3...5),
          Lookout::Diff::Operations::Insert.new(6...6, 5...6)] do
    Lookout::Diff::Operations.diff('qabxcd', 'abycdf').to_a
  end
end
