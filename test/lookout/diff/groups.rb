# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [[Lookout::Diff::Operations::Equal.new(0...0, 0...0)]] do
    Lookout::Diff::Groups.diff('', '').to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(0...3, 0...3)]] do
    Lookout::Diff::Groups.diff('abc', 'abc').to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(0...1, 0...1),
           Lookout::Diff::Operations::Replace.new(1...2, 1...2),
           Lookout::Diff::Operations::Equal.new(2...5, 2...5)],
          [Lookout::Diff::Operations::Equal.new(8...11, 8...11),
            Lookout::Diff::Operations::Replace.new(11...12, 11...12),
            Lookout::Diff::Operations::Equal.new(12...13, 12...13),
            Lookout::Diff::Operations::Delete.new(13...16, 13...13),
            Lookout::Diff::Operations::Equal.new(16...17, 13...14),
            Lookout::Diff::Operations::Replace.new(17...18, 14...15),
            Lookout::Diff::Operations::Equal.new(18...20, 15...17)]] do
    Lookout::Diff::Groups.diff('123456789abcdefghijk', '1i3456789abXdhYjk').to_a
  end

  expect [[Lookout::Diff::Operations::Insert.new(0...0, 0...1),
          Lookout::Diff::Operations::Equal.new(0...1, 1...2),
          Lookout::Diff::Operations::Replace.new(1...3, 2...3),
          Lookout::Diff::Operations::Equal.new(3...4, 3...4)]] do
    Lookout::Diff::Groups.diff(%w(one two three four), %w(zero one tree four)).to_a
  end
end
