# encoding: utf-8
require 'fibeline/generic_element'

module Fibeline
  class Filter < GenericElement
    def initialize(&block)
      @filter = block
      super
    end
  end
end
