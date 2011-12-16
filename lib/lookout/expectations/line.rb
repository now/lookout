# -*- coding: utf-8 -*-

class Lookout::Expectations::Line < Lookout::Expectations
  def initialize(results, file, line)
    super results
    @target = Lookout::Expect::Object.new(nil, file, line){
      raise RuntimeError, 'line expectation not found: %s:%d' % [file, line]
    }
    @previous = nil
  end

  def evaluate(&block)
    catch :found_expect_close_to_target do
      super
    end
    @results << (@previous || @target).call
    @previous = nil
    self
  end

  def <<(expect)
    if @previous and @previous <= @target and expect > @target
      throw :found_expect_close_to_target
    else
      @previous = expect
    end
    self
  end
end
