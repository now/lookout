# -*- coding: utf-8 -*-

class Lookout::Inspect
  def initialize(object, type)
    @object, @type = object, type
  end

  def call
    Lookout::Encode.new(inspection = inspect_object).call
  rescue => e
    '(cannot encode inspected %s for output: %s; %s)' %
      [@type,
       Lookout::Exception.new(e).message,
       begin
         'dumping instead: %s' % [inspection.dump]
       rescue => inner
         'dumping also failed: %s' % Lookout::Exception.new(inner).message
       end]
  end

  private

  def inspect_object
    String(@object.inspect)
  rescue => e
    '(cannot inspect %s: %s)' % [@type, Lookout::Exception.new(e).message]
  end
end
