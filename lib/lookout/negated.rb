# -*- coding: utf-8 -*-

module Lookout::Negated
  def verify!
    not verify
  end
end
