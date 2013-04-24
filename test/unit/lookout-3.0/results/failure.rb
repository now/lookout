# -*- coding: utf-8 -*-

Expectations do
  expect "test:1: 2≠1" do
    Lookout::Results::Failure.new('test', 1, 1.to_lookout_expected.difference(2)).to_s
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
