# A constant's Class.new / Module.new block is the class's frame (self and
# the definee) but not its constant scope: constants and classes written in
# the block belong to the scope around the write, as CRuby has them.
X = Class.new do
  Y = 1
  class Inner; def i = 1; end
  Z = Class.new { def z = 3 }
  P = Struct.new(:a) { def b = a * 2 }
  def self.y = Y
  def mk = Z.new.z
end
p defined?(Y), X.const_defined?(:Y, false), X.y
p defined?(Inner), X.const_defined?(:Inner, false), Inner.name, Inner.new.i
p Z.name, X.new.mk, X.const_defined?(:Z, false)
p P.new(2).b, X.const_defined?(:P, false), P.name

module M
  W = Class.new do
    K = :k
    def k = K
  end
end
p M::W.new.k, M.const_defined?(:K, false), defined?(M::W::K), defined?(K)

D = Class.new do
  def m = 1 unless method_defined?(:m)
  def m2 = 2
  def m2 = 3 unless method_defined?(:m2)
end
p D.new.m, D.new.m2

# The block's defs fire the class's hooks even when nothing reads the
# constant again: its own method_added, and a superclass's inherited and
# method_added.
H = Class.new do
  def self.method_added(m) = puts("added #{m}")
  def h = 1
end
class HBase
  def self.inherited(k) = puts("inherited #{k.name.inspect}")
  def self.method_added(m) = puts("base added #{m}")
end
HSub = Class.new(HBase) do
  def s = 1
end
