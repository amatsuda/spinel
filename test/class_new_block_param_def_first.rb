# A builder block that opens with a def: the prepended `k = self` swaps
# numbers with the first statement that is not a def, so the def keeps its
# subtree in preorder and a `...` forwarder defined first still forwards.
Y = Class.new do |k|
  def self.fwd(...) = tgt(...)
  def self.tgt(a, b) = p(a + b)
  n = 1
  k = n + 1
  p k
end
Y.fwd(1, 2)
X = Class.new do |k|
  def self.forward(...) = target(...)
  def self.target(*a, **kw) = p([a, kw])
end
X.forward(1, 2)
X.forward(3, z: 4)
