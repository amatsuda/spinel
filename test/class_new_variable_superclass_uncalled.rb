# A Class.new built from a variable superclass in a method nothing calls:
# its block never runs, so what it would declare on a builtin class is not
# there, and the program compiles.
def mk_thread_attrs(s)
  Class.new(s) do
    Thread.attr_accessor :tx
  end
end

def mk_more_attrs(s)
  Class.new(s) do
    Fiber.attr_accessor :fx
    Thread.attr_reader :ty
  end
end

p Thread.current.respond_to?(:tx)
t = Thread.new { 1 }
p t.value
p t.respond_to?(:tx)
p Fiber.current.respond_to?(:fx)
p Thread.method_defined?(:ty)
