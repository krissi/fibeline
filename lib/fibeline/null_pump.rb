# encoding: utf-8
require 'fibeline/generic_element'

module Fibeline
  class NullPump < GenericElement
    def process
      loop do
        value = self.next
        Fiber.yield value
      end
    end

    def next
      raise StopIteration
    end
  end
end
