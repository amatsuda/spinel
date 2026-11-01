# The class-body macro form declines: the line argument of the macro's
# module_eval adds with Integer#+, which the program redefines.
class Integer
  def +(o) = (puts "plus #{o}"; 7)
end
class Base
  def self.mk(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__ + 1
  end
end
class Foo < Base
  mk :a
end
p Foo.new.a
