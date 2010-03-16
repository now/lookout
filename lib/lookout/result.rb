# -*- coding: utf-8 -*-

module Lookout::Result
  def is(is)
    [:error, :failure, :fulfilled].each do |type|
      define_method :"#{type}?" do
        type == is
      end
    end
    attr_accessor :message
    private :message=
  end
end
