# The class-body macro form answers where an earlier effect does not change
# what a later call on self reaches: a text that defines an instance method
# of the name (self's calls do not reach it), a text that defines the name
# after the call, and a line argument of a program that leaves Integer#+
# alone (it redefines another Integer method).
class Integer
  def squared = self * self
end
class Base
  def self.mk(n)
    module_eval "def attr_reader(*a) = :instance_side"
    attr_reader n
    module_eval "def self.attr_reader(*a) = :own\ndef self.where = __LINE__", __FILE__, __LINE__ + 1
  end
end
class Foo < Base
  mk :ghost
end
p Foo.new.respond_to?(:ghost), Foo.new.attr_reader(1), Foo.attr_reader(:x), 3.squared
p Foo.where
