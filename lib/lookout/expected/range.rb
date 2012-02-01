# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end

  private

  def format(other)
    '%s%s%s' % [inspect_actual(other),
                Range === other ? '≠' : '≉',
                inspect_expected]
  end
end
