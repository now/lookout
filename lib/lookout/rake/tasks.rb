# -*- coding: utf-8 -*-

require 'rake'

module Lookout module Rake end end

module Lookout::Rake::Tasks
  %w'test'.each do |file|
    load File.expand_path('../tasks/%s.rb' % file, __FILE__)
  end
end
