# spinel: reject-subclass: a def under a condition only the run time decides, of a name another method answers
# A public def under a run-time condition over a private superclass method:
# when the branch does not run, CRuby's lookup finds P#m and raises
# "private method 'm' called"; the entry would call it as a public method,
# so the def is refused rather than standing as if it ran.
class P
  private def m = :p
end
class C < P
  def m = :c if ENV["SPINEL_TEST_UNSET_VARIABLE"]
end
p((C.new.m rescue :private))
