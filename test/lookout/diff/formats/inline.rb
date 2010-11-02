# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect 'one two three' do
    Lookout::Diff::Formats::Inline.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.new('one two three',
                                                       'one two three'))).to_s
  end

  expect 'one t[-w-]{+o+}o three' do
    Lookout::Diff::Formats::Inline.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.new('one two three',
                                                       'one too three'))).to_s
  end
end
