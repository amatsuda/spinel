# The class_eval graft adds the line argument's `+` in C, which is Integer#+
# as long as the program does not define it for Integer: a `+` of another
# class, one of Numeric or Object (Integer's own is found first), one on
# Integer's singleton class, and a literal block (the core `+` never yields)
# are no change to `__LINE__ + 1`.
class Numeric
  def +(o) = (puts "numeric plus"; 7)
end
class Object
  def -(o) = (puts "object minus"; 7)
end
class Integer
  def self.+(o) = :class_side
end
class Vec
  def +(o) = :vec
end
class Foo
  class_eval "def a = __LINE__", __FILE__, __LINE__ + 1
  class_eval "def b = __LINE__", __FILE__, __LINE__ - 1
  class_eval "def c = __LINE__", __FILE__, __LINE__.+(1) { puts "block" }
end
p Foo.new.a, Foo.new.b, Foo.new.c, (Vec.new + 1), Integer.+(1)
