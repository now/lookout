# -*- coding: utf-8 -*-

class Lookout::UI::Console
  def initialize(io = $defout)
    @io = io
  end

  def start
    print 'Expectations '
  end

  def report(result)
    print case
    when result.error? then 'E'
    when result.failure? then 'F'
    else '.'
    end
  end

  def summarize(results, time)
    @io.print "\nFinished in %f: " % [time]
    first = true
    [:errors, :failures, :fulfillments].each do |type|
      next unless (size = results.send(type).size) > 0
      @io.print '%s%d %s' % [first ? "" : ', ', size, type]
      first = false
    end
    @io.puts
    summarize_group results, :errors do |error|
      @io.puts '%s:%d: %s' % [error.file, error.line, error.exception.message]
      @io.puts filter_backtrace(error.exception.backtrace).join("\n")
      @io.puts error.message if error.message and not error.message.empty?
    end
    summarize_group results, :failures do |failure|
      @io.puts '%s:%d: %s' % [failure.file, failure.line, failure.message]
    end
    @io.flush
  end

private

  def print(string)
    @io.print string
    @io.flush
  end

  def summarize_group(results, type)
    group = results.send(type)
    return if group.empty?
    @io.puts '--%s--' % [type.to_s.capitalize]
    group.each do |item|
      yield item
      @io.puts
    end
  end

  def filter_backtrace(trace)
    [
      %r{/lib/ruby/},
      %r{lib/expectations/}
    ].inject(trace){ |r, p| r.reject{ |l| l =~ p } }.map{ |l| "\tfrom #{l}" }
  end
end
