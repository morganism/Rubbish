#!/usr/bin/env ruby
# a typed process_stream
#
#
ProcessInfo = Struct.new(:pid, :cpu, :cmd)

def ps
  Command.new(:ps) do
    `ps -axo pid,%cpu,comm`.lines.drop(1).map do |l|
      pid, cpu, cmd = l.split
      ProcessInfo.new(pid.to_i, cpu.to_f, cmd)
    end
  end
end

