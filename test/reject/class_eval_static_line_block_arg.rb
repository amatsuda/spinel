# The line argument is a call with a block argument that has to run: a graft
# would drop it, so the class_eval is not grafted.
class Foo
  class_eval "def a = __LINE__", __FILE__, __LINE__.+(1, &p(:side))
end
p Foo.new.a
