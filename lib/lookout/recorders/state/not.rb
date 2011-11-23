# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not < Lookout::Recorders::State
  def initialize(subject, *args)
    super
    @error = 'expected %p not to %s'
  end

  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods, @description, @error)]
  end

  private

  class Verify
    def initialize(subject, methods, description, error)
      @subject, @methods, @description, @error = subject, methods, description, error
    end

    def call
      @methods.play_for(@subject) and
        raise Lookout::Recorders::State::Error, @error % [@subject, @description.join(' ')]
      true
    end
  end
end
