# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# singleton_methods lists a singleton method whose branch never ran (CRuby
# prints [] for D, and for C until its branch has run): refused.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  def self.bar = 2 if !$on
end
p D.singleton_methods
p D.singleton_methods(false)
class C; end
p C.singleton_methods
class C
  def self.foo = 1 if $on
end
p C.singleton_methods
