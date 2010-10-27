# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect '[-A-]{+a+}bc' do
    Lookout::Equality.diff('abc', 'Abc')
  end

  expect 'a[-B-]{+b+}c' do
    Lookout::Equality.diff('abc', 'aBc')
  end

  expect 'ab[-C-]{+c+}' do
    Lookout::Equality.diff('abc', 'abC')
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    Lookout::Equality.diff("abc\nghi", "def\nghi")
  end

  expect true do
    Lookout::Equality.equal? String, 'foo'
  end

  expect true do
    Lookout::Equality.equal? 'foo', 'foo'
  end

  expect true do
    Lookout::Equality.equal? String, String
  end

  expect false do
    Lookout::Equality.equal? String, 0
  end

  expect true do
    object = Object.new
    Lookout::Equality.equal? object, object
  end

  expect false do
    Lookout::Equality.equal? Object.new, Object.new
  end

  expect true do
    Lookout::Equality.equal? 1..5, 3
  end

  expect true do
    Lookout::Equality.equal? 1..5, (1..5)
  end

  expect false do
    Lookout::Equality.equal? 1..5, 6
  end

  expect true do
    Lookout::Equality.equal?(/foo/, 'foo')
  end

  expect true do
    Lookout::Equality.equal?(/foo/, /foo/)
  end

  expect false do
    Lookout::Equality.equal?(/foo/, 'bar')
  end

  expect false do
    Lookout::Equality.equal?(/foo/, /bar/)
  end
end
