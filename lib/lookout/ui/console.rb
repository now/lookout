# -*- coding: utf-8 -*-

class Lookout::UI::Console
  def initialize(io = STDOUT)
    @io = io
  end

  def start
  end

  def report(result)
  end

  def summarize(results, time)
    return if results.succeeded?
    @io.printf "Ran %d expectations in %.3f seconds: %s\n",
      results.size,
      time,
      [:errors, :failures, :fulfillments].inject([]){ |result, type|
        next result unless (size = results.send(type).size) > 0
        result << '%d %s' % [size, type]
      }.join(', ')
    summarize_group results, :errors do |error|
      print_message error.file, error.line, exception_message(error.exception)
      print_backtrace error.exception.backtrace
      @io.puts error.message if error.message and not error.message.empty?
    end
    summarize_group results, :failures do |failure|
      print_message failure.file, failure.line, failure.message
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
    @io.printf "\n%s\n\n", type.to_s.upcase
    group.each do |item|
      yield item
      @io.puts
    end
  end

  def print_message(file, line, message)
    @io.printf "%s:%d: %s\n", file, line, message
  end

  def exception_message(error)
    message = error.message.to_str
    case
    when error.class == RuntimeError && message.empty?
      'unhandled error'
    when message.empty?
      error.class.name
    when error.class.name.empty?
      message
    else
      '%s (%s)' % [message.chomp("\n"), error.class.name]
    end
  end

  def print_backtrace(trace)
    @io.puts [
      %r{/lib/ruby/},
      %r{lib/lookout/}
    ].inject(trace){ |r, path| r.reject{ |location| location =~ path } }.
      map{ |location| "\tfrom #{location}" }.
      join("\n")
  end
end
