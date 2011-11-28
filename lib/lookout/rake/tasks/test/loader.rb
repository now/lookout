# -*- coding: utf-8 -*-

require 'lookout'

results = Lookout::Results.new
failed = Lookout::Results::Trackers::Failure.new(results)
line = ENV['LINE'] && ENV['LINE'].to_i
expectations = line ?
  Lookout::Expectations::Line.new(line, results) :
  Lookout::Expectations.new(results)
ui = Lookout::UI::Console.new(results)
only_load = false
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  else
    expectations.load arg
  end
end
ui.flush
exit false if failed.failed?
