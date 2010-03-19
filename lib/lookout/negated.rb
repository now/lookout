# -*- coding: utf-8 -*-

module Lookout::Negated
  def verify
    not super
  end
end
