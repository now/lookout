# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect 'one two three' do
    Lookout::Diff::Format::Inline.diff('one two three',
                                       'one two three')
  end

  expect 'one t[-w-]{+o+}o three' do
    Lookout::Diff::Format::Inline.diff('one two three',
                                       'one too three')
  end
end
