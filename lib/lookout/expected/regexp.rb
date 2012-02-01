# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end

  private

  def format(other)
    '%s%s%s' % [inspect_actual(other),
                Regexp === other ? '≠' : '≉',
                inspect_expected]
  end
end
