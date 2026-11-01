# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# Two defs of one name, each under a condition the run time decides, are
# lowered to one dispatcher; singleton_methods listed it though neither
# branch ran (CRuby prints []): refused, as a lone conditional def is.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class D
  def self.bar = 2 if !$on
  def self.bar = 3 if !$on
end
p D.singleton_methods
