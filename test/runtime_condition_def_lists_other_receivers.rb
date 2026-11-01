# singleton_methods, private_instance_methods and protected_instance_methods
# are refused only on a receiver whose chain holds a method a run-time
# condition defines. Beside such a class, a class that holds none lists its
# methods, and an object's singleton_methods does not list its class's.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  def self.bar = 2 if !$on
  private def pv = 1 if !$on
  def ok = 1
end
class Other
  def self.x = 1
  def y = 2
  private def pz = 3
  protected def pt = 4
end
class Other2 < Other
  def self.w = 5
end
p Other.singleton_methods
p Other2.singleton_methods(false)
p Other.private_instance_methods(false)
p Other.protected_instance_methods(false)
p Other2.private_instance_methods(false)
k = Other
p k.singleton_methods
p Other.new.singleton_methods
p D.new.singleton_methods
