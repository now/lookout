# -*- coding: utf-8 -*-

module Lookout::Recorder
  def initialize(subject)
    @subject = subject
  end

  def subject!(mocks)
    @subject
  end

  # TODO: #verify and #subject! shouldn’t be defined on these objects, as they
  # will interfere with the recording.  We can remove #verify by having
  # #subject! return the subject and the verifier.  The verifier will have a
  # #call method that checks that everything worked and can also be subclassed
  # to deal with error messages nicely.
end
