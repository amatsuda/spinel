# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# private_methods lists a method whose branch never ran (CRuby prints []): refused.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  private def pv = 1 if !$on
end
p D.new.private_methods(false)
