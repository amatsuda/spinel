# The macro form answers a `__LINE__ + 1` line argument that runs before the
# program defines Integer#+ (CRuby has not run that def yet).
class Base
  def self.mk(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__ + 1
  end
end
class Foo < Base
  mk :a
end
p Foo.new.a
class Integer
  def +(o) = (puts "plus #{o}"; 7)
end
puts "done"
