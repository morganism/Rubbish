# command.rb
module Rubbish
  class Command
    attr_reader :name, :args, :next_stage

    def self.exists?(name)
      true # later: lookup table, PATH cache, ruby funcs
    end

    def initialize(name, *args, &block)
      @name = name
      @args = args
      @block = block
    end

    def |(other)
      @next_stage = other
      self
    end

    def execute(input = nil)
      output =
        if ruby?
          run_ruby(input)
        else
          run_exec(input)
        end

      @next_stage ? @next_stage.execute(output) : output
    end

    def render
      execute
    end

    private

    def ruby?
      @block
    end

    def run_ruby(input)
      enum = input || []
      enum.map { |x| @block.call(x) }
    end

    def run_exec(input)
      cmd = ([name] + args).join(" ")
      result = `#{cmd}`
      result.lines
    end
  end
end

