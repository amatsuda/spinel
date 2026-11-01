# The class-body macro form declines: a statement it would leave as written
# defines methods on another class (the steps before the walk read such a
# call wherever it stands).
class Target; end
class Base
  def self.mk(n)
    Target.attr_accessor(n)
    define_method(n) { 1 }
  end
end
class Foo < Base
  mk :a
end
t = Target.new
t.a = 2
p t.a, Foo.new.a
