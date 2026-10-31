# A class-body macro whose block answers a String local the macro writes
# twice: the call's statements write it twice too, and the block reads the
# object the second write made.
class Base
  def self.mk(n)
    s = "a#{n}"
    s = "b#{n}"
    define_method(n) { s }
  end
end
class Foo < Base
  mk :x
end
f = Foo.new
f.x << "!"
p f.x
