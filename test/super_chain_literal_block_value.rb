# A super with a literal block whose parent only hands the block on
# (`super()`, a bare `super`, `super(&b)`) to a grandparent that yields: the
# child's method answers the block's value, as it does when the parent yields
# itself. The middle method has no call site of its own, so its yield value
# came from nowhere, and the child answered nil (or was emitted as void).
class A
  def f = yield("abc")
  def g(x) = yield(x)
  def h(&b) = b.call(2)
end
class B < A
  def f(c) = super()
  def g(x)
    super
  end
  def h(&b) = super(&b)
end
class C < B
  def f(c) = super(c) { |s| s.upcase }
  def g(x)
    r = super(x) { |v| v * 3 }
    p r
    r + 1
  end
  def h = super { |n| n + 40 }
end
p C.new.f(1)
p C.new.g(2)
p C.new.h
# three levels: the block value passes two middle methods
class D < C
  def f(c) = super(c)
end
p D.new.f(1)
# a block that reads the child's locals, and one with a `next`
class E < B
  def f(c)
    pre = "x"
    super(c) { |s| next pre if c > 1; s + pre }
  end
end
p E.new.f(1), E.new.f(2)
