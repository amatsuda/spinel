# When the branch does not run, Child#foo is the reader Parent declares
# (CRuby: :inherited): the def under a condition only the run time decides
# answers only once its branch ran.
class Parent
  attr_reader :foo
  def initialize = @foo = :inherited
end
class Child < Parent
  if ENV["SPINEL_TEST_UNSET_VARIABLE"]
    def foo = :child
  end
end
p Child.new.foo
