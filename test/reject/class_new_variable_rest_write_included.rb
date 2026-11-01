# spinel: reject-subclass: Class.new with a non-constant superclass
# The builder is the first statement of a module method whose *rest
# parameter is written later; each including class gets a copy of it.
module M
  def build(*a)
    Class.new(a.first) { def z = 1 }
    a += [1]
    a.size
  end
end
class A; include M; end
class B; include M; end
p A.new.build(Object)
p B.new.build(String)
