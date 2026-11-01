# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# instance_methods stays refused for the whole program, as it was: a list on
# a class that holds no conditional def too, beside one that does.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  def baz = 3 if !$on
end
class Other
  def y = 2
end
p Other.instance_methods(false)
