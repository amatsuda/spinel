# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
# A class that includes a module whose method is defined under a condition:
# its list of methods names the method before its branch has run.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
module M
  def mm = 1 if !$on
end
class Inc
  include M
end
p Inc.new.methods.include?(:mm)
