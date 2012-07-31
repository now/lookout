# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Expect::Object] do
    stub(Lookout::Expectations, :load => [proc{ expect 1 do 1 end }]){
      Lookout::Expectations.new(nil).entries
    }
  end

  expect [Lookout::Results::Error] do
    begin
      stub(Lookout::Expectations, :load => [proc{ expect 1 do exit end }]){
        Lookout::Expectations.new(nil).map(&:call)
      }
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect [Lookout::Results::Error] do
    begin
      stub(Lookout::Expectations, :load => [proc{ expect 1 do raise NoMemoryError end }]){
        Lookout::Expectations.new(nil).map(&:call)
      }
    rescue NoMemoryError
      raise 'NoMemoryError not caught'
    end
  end

  expect [Lookout::Results::Error] do
    begin
      stub(Lookout::Expectations, :load => [proc{ expect 1 do raise SignalException end }]){
        Lookout::Expectations.new(nil).map(&:call)
      }
    rescue SignalException
      raise 'SignalException not caught'
    end
  end

  expect [Lookout::Results::Error] do
    begin
      stub(Lookout::Expectations, :load => [proc{ expect 1 do raise Interrupt end }]){
        Lookout::Expectations.new(nil).map(&:call)
      }
    rescue Interrupt
      raise 'Interrupt not caught'
    end
  end

  expect [Lookout::Results::Error] do
    stub(Lookout::Expectations, :load => [proc{ this_method_is_not_defined }]){
      Lookout::Expectations.new(nil).map(&:call)
    }
  end
end
