# -*- coding: utf-8 -*-

Expectations do
  expect 'fo[o bar baz|a bar bat]' do
    Lookout::Utilities.diff('foo bar baz', 'foa bar bat')
  end
end
