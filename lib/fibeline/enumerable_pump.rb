# encoding: utf-8
require 'fibeline/null_pump'

module Fibeline
  class EnumerablePump < NullPump
    def initialize(enumerable)
      @enumerable = enumerable.to_enum
      super()
    end

    def next
      @enumerable.next
    end
  end
end
