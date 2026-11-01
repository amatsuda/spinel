# The block parameter of a constant's Class.new / Module.new block is the
# class or module being defined, self in the block.
X = Class.new do |k|
  p k == self
  def a = 1
end
p X.new.a

M = Module.new do |m|
  p m.equal?(self)
  def mm = :mm
end
class K; include M; end
p K.new.mm

k = 7
Y = Class.new do |k; z|
  z = 1
  p k.equal?(self), z
  def y = 2
end
p Y.new.y, k

# a constant the block writes is the block's scope's: written with the
# parameter before the builder's own constant, it names the class first
Z = Class.new do |k|
  K2 = k
end
p K2.equal?(Z), K2.name, Z.name
