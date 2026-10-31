# spinel: reject-subclass: a def under a condition only the run time decides, of a name another method answers
# A module's def under a run-time condition, of a name another method
# answers (Z#m): C, which includes the module twice, and D, whose own m
# stands in front of it, cannot both be given an entry that chooses the
# version, so the def is refused rather than standing as if it ran
# (CRuby: NoMethodError for C.new.m, :d for D.new.m).
class Z
  def m = :z
end
module M
  def m = :m if ENV["SPINEL_TEST_UNSET_VARIABLE"]
end
class C
  include M
  include M
end
class D
  include M
  def m = :d
end
p((C.new.m rescue :nomethod))
p D.new.m
