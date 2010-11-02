# -*- coding: utf-8 -*-

require 'lookout'

ARGV.each do |arg|
  if arg =~ /-r(.*)/
    require $1
  else
    load arg
  end
end
