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

# a plain write makes the parameter a local of its own from there on; a
# lambda made before the write, or a conditional write, shares it
W = Class.new do |k|
  def self.tag = "w"
  s = k.tag
  k = s * 2
  p k, k.size
end
V = Class.new do |k|
  def self.v = 10
  pr = -> { k }
  k = k.v + 1
  p pr.call, k
end
U = Class.new do |k|
  def self.tag = "u"
  s = k.tag
  k = s * 2 if s
  p k, k.size
end
