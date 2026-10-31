# The class-body macro form declines: a statement it would leave as written
# builds a class (the steps before the walk read Struct.new wherever it
# stands).
class Base
  REG = []
  def self.mk(n)
    REG << Struct.new(n)
    define_method(n) { 1 }
  end
end
class Foo < Base
  mk :a
end
p Base::REG.size, Foo.new.a
