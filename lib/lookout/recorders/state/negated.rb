# -*- coding: utf-8 -*-

module Lookout::Recorders::State::Negated
  def verify
    not super
  end
end
