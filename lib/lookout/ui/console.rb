# -*- coding: utf-8 -*-

class Lookout::UI::Console
  def initialize(results, io = $stdout)
    @results, @io = results, io
    @count = 0
    results.on_new do
      @count += 1
    end
  end

  def start
    @start = Time.now.to_f
  end

  def summarize
    return if @results.succeeded?
    summarize_total
    summarize_group :errors
    summarize_group :failures
    @io.flush
  end

private

  def summarize_total
    @io.printf "Ran %d expectations in %.3f seconds: %s\n",
      @count,
      Time.now.to_f - @start,
      [['errors', @results.errors.size],
       ['failures', @results.failures.size]].tap{ |types|
        types << ['fulfillments', @count - types.reduce(0){ |sum, pair| sum + pair[1] }]
      }.select{ |type, size| size > 0 }.
        map{ |type, size| '%d %s' % [size, type] }.
        join(', ')
  end

  def summarize_group(type)
    group = @results.send(type)
    return if group.empty?
    @io.puts '', type.to_s.upcase, ''
    group.each do |item|
      @io.puts item, ''
    end
  end
end
