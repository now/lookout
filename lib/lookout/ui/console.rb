# -*- coding: utf-8 -*-

class Lookout::UI::Console < Lookout::UI::Silent
  def initialize(io = $stdout)
    @io = io
  end

  def summarize(results, time)
    return if results.succeeded?
    summarize_total results, time
    summarize_group results, :errors
    summarize_group results, :failures
    @io.flush
  end

private

  def summarize_total(results, time)
    @io.printf "Ran %d expectations in %.3f seconds: %s\n",
      results.size,
      time,
      [:errors, :failures, :fulfillments].inject([]){ |result, type|
        next result unless (size = results.send(type).size) > 0
        result << '%d %s' % [size, type]
      }.join(', ')
  end

  def summarize_group(results, type)
    group = results.send(type)
    return if group.empty?
    @io.puts '', type.to_s.upcase, ''
    group.each do |item|
      @io.puts item, ''
    end
  end
end
