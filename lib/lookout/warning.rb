# -*- coding: utf-8 -*-

class Lookout::Warning < String
  def inspect
    'warning(%s)' % super
  end
end
