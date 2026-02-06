# shell_vm.rb
require "readline"

module Rubbish
  class VM
    def initialize
      @env = {}
      @last = nil
    end

    def repl
      loop do
        line = Readline.readline("☉ ", true)
        break if line.nil? || line.strip == "exit"

        begin
          @last = eval_line(line)
          puts render(@last)
        rescue => e
          warn "💥 #{e.class}: #{e.message}"
        end
      end
    end

    def eval_line(line)
      ctx = DSLContext.new(self)
      ctx.instance_eval(line)
    end

    def render(obj)
      return "" if obj.nil?
      obj.respond_to?(:render) ? obj.render : obj.inspect
    end
  end
end

