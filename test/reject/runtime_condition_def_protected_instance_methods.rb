# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# protected_instance_methods lists a method whose branch never ran (CRuby prints []): refused.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  protected def pt = 1 if !$on
end
p D.protected_instance_methods(false)
