# The class-body macro form declines: a macro with a rest parameter.
class Base
  def self.mk(n, *rest) = define_method(n) { rest.size }
end
class Foo < Base
  mk :x, 1, 2
end
p Foo.new.x
