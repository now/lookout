# -*- coding: utf-8 -*-

class Lookout::Expect::Lookout::Reception < Lookout::Expect::Object
  def evaluate_block(subject = @expected.subject)
    proc{ @block ? Context.new(subject, &@block).evaluate : false }
  end
end
