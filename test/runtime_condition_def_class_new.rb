# A def under a condition only the run time decides, in a Class.new block,
# defines its method only when its branch runs (CRuby: NoMethodError when
# the branch does not run).
Foo = Class.new do
  if ENV["SPINEL_TEST_UNSET_VARIABLE"]
    def foo = 1
  end
end
begin
  p Foo.new.foo
rescue NoMethodError => e
  puts e.message
end
