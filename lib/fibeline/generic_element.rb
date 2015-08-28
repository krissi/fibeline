# encoding: utf-8

module Fibeline
  class GenericElement
    include Enumerable

    attr_writer :source

    def initialize
      @transformer    ||= method(:transform)
      @filter         ||= method(:filter)
      @fiber_delegate = Fiber.new do
        process
      end
    end

    def each
      while (value = resume)
        yield value
      end
    end

    def |(other=nil, &block)
      other        = Transformer.new(&block) if block
      other.source = self
      other
    end

    def resume
      @fiber_delegate.resume
    end

    def process
      while (value = input)
        handle_value(value)
      end
    end

    def handle_value(value)
      output(@transformer.call(value)) if @filter.call(value)
    end

    def source
      @source ||= NullPump.new
    end

    def input
      source.resume
    end

    def output(value)
      Fiber.yield(value)
    end

    def transform(value)
      value
    end

    def filter(value)
      true
    end
  end
end
