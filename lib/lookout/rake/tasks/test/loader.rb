# -*- coding: utf-8 -*-

require 'lookout'

results = Lookout::Results.new
line = ENV['LINE'] && ENV['LINE'].to_i
runner = Lookout::Runners::Console.new(results,
                                       line ?
                                         Lookout::Expectations::Line.new(line, results) :
                                         Lookout::Expectations.new(results),
                                       Lookout::UI::Console.new(results)).install
only_load = false
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  else
    runner.load arg
  end
end
runner.exit
