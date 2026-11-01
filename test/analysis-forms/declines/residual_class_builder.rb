# The class-body macro form declines: a statement it would leave as written
# builds a class (the steps before the walk read Struct.new wherever it
# stands). The macro is defined and called in one body and reads no constant
# of its own, so the builder is the only reason.
class Foo
  def self.mk(n)
    Struct.new(n)
    define_method(n) { 1 }
  end
  mk :a
end
p Foo.new.a
