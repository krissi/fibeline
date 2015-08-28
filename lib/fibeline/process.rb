# encoding: utf-8

require 'open3'
require 'fibeline/generic_element'

module Fibeline
  class ProcessTransformer < GenericElement
    def initialize(*popen_arguments)
      @popen_arguments = popen_arguments
      super()
    end

    def process
      Open3.popen3(*@popen_arguments) do |stdin, stdout, _|
        while (value = input)
          stdin.puts value
        end
        stdin.close

        stdout.each_line do |output_line|
          output(output_line.rstrip)
        end
        stdout.close
      end
    end
  end
end
