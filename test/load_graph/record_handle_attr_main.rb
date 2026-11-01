# `Thread.attr_accessor :x` and `Fiber.attr_reader :x` define the methods
# where the declaration stands (--dump-load-record,
# record_handle_attr_main.rb.load-record), under its frame and its
# conditions: in a module body after the program's own `Thread#x`, the
# declaration's reader is the later version, which the call reaches; under
# an `if`, its reader may be defined. A thread keeps the attribute in its
# own store, so another thread's is nil. A declaration in a block keeps
# the end of the file; one in a module that defines its own Thread only
# later names the core Thread.
module Cfg
  class ::Thread
    def x = :own
  end
  Thread.attr_accessor :x
end
Thread.current.x = 7
p Thread.current.x
p Thread.new { Thread.current.x }.value
if ARGV.empty?
  Fiber.attr_reader :tag
end
p Fiber.current.tag
Object.new.instance_eval { Thread.attr_reader :ie }
p Thread.current.ie
module Own
  Thread.attr_accessor :own_x
  class Thread
    def hi = :mt
  end
end
Thread.current.own_x = 2
p Thread.current.own_x, Own::Thread.new.hi
