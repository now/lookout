# -*- coding: utf-8 -*-

class Lookout::Inspect
  def initialize(object, type)
    @object, @type = object, type
  end

  def call
    (inspection = inspect_object).encode('UTF-8')
  rescue => e
    '(cannot encode inspected %s for output: %s; %s)' %
      [@type,
       Error.new(e).call,
       begin
         'dumping instead: %s' % [inspection.dump]
       rescue => inner
         'dumping also failed: %s' % Error.new(inner).call
       end]
  end

  private

  def inspect_object
    String(@object.inspect)
  rescue => e
    '(cannot inspect %s: %s)' % [@type, Error.new(e).call]
  end
end
