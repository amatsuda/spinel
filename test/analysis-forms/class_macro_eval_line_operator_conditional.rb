# The macro form answers a `__LINE__ + 1` line argument where the program
# defines Integer#+ and #- only under conditions that do not hold: the record
# cannot tell whether the branch ran, and the answer stays the fold's.
class Integer
  def +(o) = (puts "plus #{o}"; 7) if ENV["SPINEL_TEST_UNSET_VARIABLE"]
  if ENV["SPINEL_TEST_UNSET_VARIABLE"]
    def -(o) = (puts "minus #{o}"; 7)
  end
end
class Base
  def self.mk(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__ + 1
  end
  def self.mk2(n)
    module_eval "def #{n} = __LINE__", __FILE__, __LINE__ - 1
  end
end
class Foo < Base
  mk :a
  mk2 :b
end
p Foo.new.a, Foo.new.b
