# -*- coding: utf-8 -*-

class Lookout::UI::Console
  def initialize(io = STDOUT)
    @io = io
  end

  def start
    print 'Expectations'
  end

  def report(result)
    print case
    when result.fulfilled? then '.'
    when result.failure? then 'F'
    else 'E'
    end
  end

  def summarize(results, time)
    @io.printf "\nRan for %.3f seconds: %s\n", time,
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
    @io.printf "\n%s\n%s\n\n", type.to_s.capitalize, '-' * type.to_s.length
    group.each do |item|
      yield item
      @io.puts
    end
  end

  def print_message(file, line, message)
    @io.printf "%s:%d: %s\n", file, line, message
  end

  def exception_message(error)
    case
    when error.class == RuntimeError && error.message.empty?
      'unhandled error'
    when error.message.empty?
      error.class.name
    when error.class.name.empty?
      error.message
    else
      '%s (%s)' % [error.message.chomp("\n"), error.class.name]
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
