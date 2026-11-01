# The class-body macro form declines: a statement it would leave as written
# changes a String the macro goes on to name a method by.
class Base
  def self.mk(n)
    s = "#{n}_x"
    s << "y"
    define_method(s) { 1 }
  end
end
class Foo < Base
  mk :a
end
p Foo.instance_methods(false)
