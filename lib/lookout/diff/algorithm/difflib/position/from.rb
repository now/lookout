# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithm::Difflib::Position::From < Lookout::Diff::Range
  def initialize(items, range = 0...items.size)
    super
  end

  def at(range)
    Lookout::Diff::Range.new(items, range)
  end
end
