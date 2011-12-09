# -*- coding: utf-8 -*-

class Lookout::Expectations::Output < Lookout::Expectations::Object
  private

  def evaluate_block
    output = StringIO.new
    super output
    @expected.subject.class.new(output.string)
  end
end
