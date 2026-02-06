# dsl_context.rb
module Rubbish
  class DSLContext
    def initialize(vm)
      @vm = vm
    end

    def _( )
      @vm.instance_variable_get(:@last)
    end

    def method_missing(name, *args, &block)
      if Command.exists?(name)
        Command.new(name, *args, &block)
      else
        super
      end
    end
  end
end

