# -*- coding: utf-8 -*-

class Lookout::Warning < String
  Lookout::Expectation.map self, Lookout::Expectations::State::Warning

  def inspect
    'warning(%s)' % super
  end
end
