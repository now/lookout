# -*- coding: utf-8 -*-

require 'rake'

module Lookout
  # Namespace for Rake-related namespaces.
  module Rake
  end
end

# Namespace for Rake tasks.
module Lookout::Rake::Tasks
  %w'test'.each do |file|
    load File.expand_path('../tasks/%s.rb' % file, __FILE__)
  end
end
