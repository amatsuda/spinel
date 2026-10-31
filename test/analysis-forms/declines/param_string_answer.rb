# The class-body macro form declines: a block answers a String parameter,
# an object the call site made.
class Base
  def self.mk(n, s) = define_method(n) { s }
end
class Foo < Base
  mk :x, "v#{1}"
end
f = Foo.new
f.x << "!"
p f.x
