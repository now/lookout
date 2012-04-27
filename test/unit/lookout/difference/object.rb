# -*- coding: utf-8 -*-

Expectations do
  expect '2≠1' do
    1.to_lookout_expected.difference(2).message
  end

  expect '(cannot inspect actual result: error)≠nil' do
    nil.to_lookout_expected.difference(stub(:inspect => proc{ raise 'error' })).message
  end

  expect 'nil≠(cannot inspect expected value: error)' do
    Lookout::Expected::Object.new(stub(:inspect => proc{ raise 'error' })).difference(nil).message
  end

  expect '2≠1 (cannot generate more specific failure message: error)' do
    Class.new(Lookout::Difference::Object){
      def message
        raise 'error'
      end
    }.new(2, 1).to_s
  end

  expect '2≠1: (cannot diff expected value and actual result: error)' do
    Class.new(Lookout::Difference::Object){
      def diff
        raise 'error'
      end
    }.new(2, 1).to_s
  end
end
