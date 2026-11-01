# spinel: reject-subclass: Class.new with a non-constant superclass
# The *rest parameter is written in a branch after the builder.
def build(cond, *a)
  Class.new(a.first) { def z = 1 }
  if cond then a = [] end
  a.size
end
p build(true, Object)
