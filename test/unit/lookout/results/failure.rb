# -*- coding: utf-8 -*-

Expectations do
  # TODO: Are these three tests worth it?
  expect true do
    Lookout::Results::Failure.new('a', 1, nil) == Lookout::Results::Failure.new('a', 1, nil)
  end

  expect true do
    Lookout::Results::Failure.new('a', 1, 'b') == Lookout::Results::Failure.new('a', 1, 'b')
  end

  expect false do
    Lookout::Results::Failure.new('a', 1, nil) == Lookout::Results::Failure.new('a', 1, 'b')
  end

  expect "test:1: 2≠1" do
    Lookout::Results::Failure.new('test', 1, 1.to_lookout_expected.difference(2)).to_s
  end

  expect 'test:1: 2≠1 (cannot generate more specific failure message: error)' do
    Lookout::Results::Failure.
      new('test', 1,
          Class.new(Lookout::Difference::Object){
            def message
              raise 'error'
            end
          }.new(2, 1)).to_s
  end

  expect 'test:1: 2≠1: (cannot diff expected value and actual result: error)' do
    Lookout::Results::Failure.
      new('test', 1,
          Class.new(Lookout::Difference::Object){
            def diff
              raise 'error'
            end
          }.new(2, 1)).to_s
  end

  expect 'test:1: "b"≠"a": [-b-]{+a+}' do
    Lookout::Results::Failure.new('test', 1, 'a'.to_lookout_expected.difference('b')).to_s
  end

  expect <<EOM.chomp do
test:1: "b\\nc"≠"a"
@@ -1,2 +1,1 @@
-b
-c
+a
EOM
    Lookout::Results::Failure.new('test', 1, 'a'.to_lookout_expected.difference("b\nc")).to_s
  end
end
