# A class-body macro with an optional parameter the call leaves out: its default.
class Base
  def self.mk(n, v = 1) = define_method(n) { v }
end
class Foo < Base
  mk :a
end
p Foo.new.a
