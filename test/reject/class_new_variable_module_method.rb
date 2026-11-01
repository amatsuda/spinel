# spinel: reject-subclass: Class.new with a non-constant superclass
# The builder sits in a module method that each including class gets a copy of.
module M
  def mk(s) = Class.new(s) { def a = 1 }
end
class A; include M; end
class B; include M; end
p A.new.mk(Object).new.a
p B.new.mk(String).new.a
