# When the branch does not run, B#foo is A's (CRuby: :a): the def under a
# condition only the run time decides answers only once its branch ran.
class A
  def foo = :a
end
class B < A
  if ENV["SPINEL_TEST_UNSET_VARIABLE"]
    def foo = :b
  end
end
p B.new.foo
