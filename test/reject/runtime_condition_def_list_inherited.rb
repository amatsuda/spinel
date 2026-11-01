# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# A subclass's chain holds the method its superclass defines under a
# condition: singleton_methods and instance_methods of the subclass, and
# methods of its instances, list it too early (CRuby prints [] for the first).
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  def self.bar = 2 if !$on
  def baz = 3 if !$on
end
class Sub < D; end
p Sub.singleton_methods
p Sub.instance_methods(false)
p Sub.new.methods.include?(:baz)
