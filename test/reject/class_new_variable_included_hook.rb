# spinel: reject-subclass: Class.new with a non-constant superclass
# The builder's superclass is the included hook's parameter.
module M
  def self.included(base)
    base.const_set(:K, Class.new(base))
  end
end
class A; include M; end
p A::K.superclass
