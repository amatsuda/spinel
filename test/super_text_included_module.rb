# `def inspect = super` / `def to_s = super` reach an included module's
# method, or an Object reopening's, before Kernel's.
module Pretty
  def inspect = "pretty"
  def to_s = "PRETTY"
end
class C
  include Pretty
  def inspect = super
  def to_s = super
end
p C.new
puts C.new

class Object
  def inspect = "obj"
end
class J
  def inspect = super
end
p J.new

module Tag
  def to_s = "tag:" + super
end
class K
  include Tag
  def to_s = "k:" + super
end
puts K.new.to_s.sub(/0x\h+/, "X")

# a subclass of a plain class: the Object reopening is still in the chain
class Plain; end
class L < Plain
  def inspect = super
  def greet = super + "!"
end
class Object
  def greet = "hi"
end
p L.new
p L.new.greet
