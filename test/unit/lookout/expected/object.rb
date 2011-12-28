# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Object do
    Object.new.to_lookout_expected.actualize('test', 1)
  end

  expect true do
    object = Object.new
    object.to_lookout_expected =~ object
  end

  expect true do
    1.to_lookout_expected =~ 1
  end

  expect false do
    Object.new.to_lookout_expected =~ Object.new
  end

  expect false do
    1.to_lookout_expected =~ 2
  end

  expect '2≠1' do
    1.to_lookout_expected.message(2)
  end

  expect '(cannot inspect actual result: error)≠nil' do
    nil.to_lookout_expected.message(stub(:inspect => proc{ raise 'error' }))
  end

  expect 'nil≠(cannot inspect expected value: error)' do
    Lookout::Expected::Object.new(stub(:inspect => proc{ raise 'error' })).message(nil)
  end

  expect '2≠1 (cannot generate more specific failure message: error)' do
    Class.new(Lookout::Expected::Object){
      def format(other)
        raise 'error'
      end
    }.new(1).message(2)
  end

  expect '2≠1: (cannot diff expected value and actual result: error)' do
    Class.new(Lookout::Expected::Object){
      def diff(other)
        raise 'error'
      end
    }.new(1).message(2)
  end

  expect '"b"≠"a": [-b-]{+a+}' do
    'a'.to_lookout_expected.message('b')
  end

  expect <<EOM.chomp do
"b\\nc"≠"a"
@@ -1,2 +1,1 @@
-b
-c
+a
EOM
    'a'.to_lookout_expected.message("b\nc")
  end
end
