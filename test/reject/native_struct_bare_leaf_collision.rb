# A native class declared under a qualified path ("Outer::Thing") and a
# program class named by its leaf alone (Thing) are two classes in CRuby.
# Constant lookups here are keyed on the leaf, so the two would merge into
# one class whose C struct is the native one. The compiler refuses the
# program.
module MyNative
  native_struct "Outer::Thing", "sp_Thing"
end

class Thing
  def initialize; @n = 5; end
  def x = @n
end

p Thing.new.x
