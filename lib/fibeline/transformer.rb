# encoding: utf-8
require 'fibeline/generic_element'

module Fibeline
  class Transformer < GenericElement
    def initialize(&block)
      @transformer = block
      super
    end
  end
end
