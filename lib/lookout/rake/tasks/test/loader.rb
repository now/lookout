# -*- coding: utf-8 -*-

require 'lookout'

runner = Lookout::Runners::Console.new.install
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
