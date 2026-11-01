# The class-body macro form declines: a statement it would leave as written
# returns from the macro.
class Base
  def self.mk(n)
    return if n == :skip
    define_method(n) { 1 }
  end
end
class Foo < Base
  mk :skip
  mk :a
end
p Foo.instance_methods(false)
