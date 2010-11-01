# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.new('', ''))).to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abc', 0..2),
                                                Lookout::Diff::Range.new('abc', 0..2))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.new('abc', 'abc'))).to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abcdefg', 4..6),
                                                Lookout::Diff::Range.new('abcdefg', 4..6))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new('abcdefg',
                      'abcdefg'))).to_a
  end

  expect [[Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('Abcdefg', 0..0),
                                                  Lookout::Diff::Range.new('abcdefg', 0..0)),
           Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('Abcdefg', 1..3),
                                                Lookout::Diff::Range.new('abcdefg', 1..3))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new('Abcdefg',
                      'abcdefg'))).to_a
  end

  expect [[Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('Abcdefgh', 0..0),
                                                  Lookout::Diff::Range.new('abcdefgh', 0..0)),
           Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('Abcdefgh', 1..3),
                                                Lookout::Diff::Range.new('abcdefgh', 1..3))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new('Abcdefgh',
                      'abcdefgh'))).to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abcdefgHijklmno', 4..6),
                                                Lookout::Diff::Range.new('abcdefghijklmno', 4..6)),
           Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('abcdefgHijklmno', 7..7),
                                                  Lookout::Diff::Range.new('abcdefghijklmno', 7..7)),
           Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abcdefgHijklmno', 8..10),
                                                Lookout::Diff::Range.new('abcdefghijklmno', 8..10))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new('abcdefgHijklmno',
                      'abcdefghijklmno'))).to_a
  end

  expect [[Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 0..0),
                                                Lookout::Diff::Range.new('1i3456789abXdhYjk', 0..0)),
           Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('123456789abcdefghijk', 1..1),
                                                  Lookout::Diff::Range.new('1i3456789abXdhYjk', 1..1)),
           Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 2..4),
                                                Lookout::Diff::Range.new('1i3456789abXdhYjk', 2..4))],
          [Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 8..10),
                                                Lookout::Diff::Range.new('1i3456789abXdhYjk', 8..10)),
            Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('123456789abcdefghijk', 11..11),
                                                   Lookout::Diff::Range.new('1i3456789abXdhYjk', 11..11)),
            Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 12..12),
                                                 Lookout::Diff::Range.new('1i3456789abXdhYjk', 12..12)),
            Lookout::Diff::Operations::Delete.new(Lookout::Diff::Range.new('123456789abcdefghijk', 13..15),
                                                  Lookout::Diff::Range.new('1i3456789abXdhYjk', 13...13)),
            Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 16..16),
                                                 Lookout::Diff::Range.new('1i3456789abXdhYjk', 13..13)),
            Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('123456789abcdefghijk', 17..17),
                                                   Lookout::Diff::Range.new('1i3456789abXdhYjk', 14..14)),
            Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('123456789abcdefghijk', 18..19),
                                                 Lookout::Diff::Range.new('1i3456789abXdhYjk', 15..16))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new('123456789abcdefghijk',
                      '1i3456789abXdhYjk'))).to_a
  end

  expect [[Lookout::Diff::Operations::Insert.new(Lookout::Diff::Range.new(%w[one two three four], 0...0),
                                                 Lookout::Diff::Range.new(%w[zero one tree four], 0..0)),
          Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new(%w[one two three four], 0..0),
                                               Lookout::Diff::Range.new(%w[zero one tree four], 1..1)),
          Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new(%w[one two three four], 1..2),
                                                 Lookout::Diff::Range.new(%w[zero one tree four], 2..2)),
          Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new(%w[one two three four], 3..3),
                                               Lookout::Diff::Range.new(%w[zero one tree four], 3..3))]] do
    Lookout::Diff::Groups.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithm::Difflib.
                  new(%w[one two three four],
                      %w[zero one tree four]))).to_a
  end
end
