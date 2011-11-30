# -*- coding: utf-8 -*-

Expectations do
  expect true do
    object = Object.new
    Lookout::Equality.equal? object, object
  end

  expect true do
    Lookout::Equality.equal? 1, 1
  end

  expect false do
    Lookout::Equality.equal? Object.new, Object.new
  end

  expect false do
    Lookout::Equality.equal? 1, 2
  end

  expect '2≠1' do
    Lookout::Equality.message(1, 2)
  end

  expect '(cannot inspect actual result: error)≠nil' do
    Lookout::Equality.message(nil, stub(:inspect => proc{ raise 'error' }))
  end

  expect 'nil≠(cannot inspect expected value: error)' do
    Lookout::Equality.message(stub(:inspect => proc{ raise 'error' }), nil)
  end

  expect '2≠1 (cannot generate more specific failure message: error)' do
    Class.new(Lookout::Equalities::Object){
      def format(expected, actual)
        raise 'error'
      end
    }.new.message(1, 2)
  end

  expect '2≠1: (cannot diff expected value and actual result: error)' do
    Class.new(Lookout::Equalities::Object){
      def diff(expected, actual)
        raise 'error'
      end
    }.new.message(1, 2)
  end

  expect '"b"≠"a": [-b-]{+a+}' do
    Lookout::Equality.message('a', 'b')
  end

  expect <<EOM.chomp do
"b\\nc"≠"a"
@@ -1,2 +1,1 @@
-b
-c
+a
EOM
    Lookout::Equality.message('a', "b\nc")
  end
end
