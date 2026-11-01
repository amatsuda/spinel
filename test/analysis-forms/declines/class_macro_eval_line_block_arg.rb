# The class-body macro form declines: the line argument of the macro's
# module_eval is a call with a block argument that has to run.
class Base
  def self.mk(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__.+(1, &p(:side))
  end
end
class Foo < Base
  mk :a
end
p Foo.new.a
