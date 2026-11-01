# The macro form answers a `__LINE__ + 1` line argument where the program
# defines no Integer#+: one of Numeric or on Integer's singleton class, and
# a Vec#+ that another macro defines are no change, and a literal block on
# the operator call is never yielded to.
class Numeric
  def +(o) = (puts "numeric plus"; 7)
end
class Integer
  def self.+(o) = :class_side
end
class Base
  def self.op(n) = define_method(n) { |o| self.class.new }
  def self.mk(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__ + 1
  end
  def self.mk2(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__.+(1) { puts "block" }
  end
end
class Vec < Base
  op :+
end
class Foo < Base
  mk :a
  mk2 :b
end
p Foo.new.a, Foo.new.b, (Vec.new + 1).class
