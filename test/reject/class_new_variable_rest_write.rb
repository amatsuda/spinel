# spinel: reject-subclass: Class.new with a non-constant superclass
# The method writes its *rest parameter after the builder, so the write's
# lowering numbers a copy of the parameter ahead of the builder.
def build(*a)
  Class.new(a.first) { def z = 1 }
  a += [1]
  a.size
end
p build(Object)
