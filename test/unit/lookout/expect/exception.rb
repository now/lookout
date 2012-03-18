# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    RuntimeError.new('error').to_lookout_expected.expect('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    RuntimeError.new('error').to_lookout_expected.expect('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Exception.new(RuntimeError.new('b'),
                                           RuntimeError.new('a'))) do
    RuntimeError.new('a').to_lookout_expected.expect('test', 1){ raise 'b' }.call
  end

  expect Lookout::Results::Error do
    StandardError.new('a').to_lookout_expected.expect('test', 1){ raise 'b' }.call
  end

  expect 'RuntimeError≠StandardError' do
    StandardError.new('a').to_lookout_expected.expect('test', 1){ raise 'b' }.call.message
  end

  expect Lookout::Results::Error do
    RuntimeError.new.to_lookout_expected.expect('test', 1){
      raise Class.new(RuntimeError){
        def class
          raise 'no class for you'
        end
      }
    }.call
  end

  expect '(cannot determine class of exception: no class for you)≠RuntimeError' do
    RuntimeError.new.to_lookout_expected.expect('test', 1){
      raise Class.new(RuntimeError){
        def class
          raise 'no class for you'
        end
      }
    }.call.message
  end

  expect Lookout::Results::Error do
    Class.new(RuntimeError){
      def class
        raise 'no class for you'
      end
    }.new('a').to_lookout_expected.expect('test', 1){ raise 'b' }.call
  end

  expect 'RuntimeError≠Exception' do
    Class.new(RuntimeError){
      def class
        raise 'no class for you'
      end
    }.new('a').to_lookout_expected.expect('test', 1){ raise 'b' }.call.message
  end
end
