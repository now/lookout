# -*- coding: utf-8 -*-

require 'lookout'

ARGV.each do |arg|
  begin
    if arg =~ /-r(.*)/
      require $1
    else
      load arg
    end
  rescue SyntaxError => e
    raise e unless matches = %r{\A(.*?:\d+): (.*)}m.match(e.message)
    raise SyntaxError, matches[2], [matches[1]]
  end
end
