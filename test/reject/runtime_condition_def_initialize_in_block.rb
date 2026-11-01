# spinel: reject-subclass: a def under a condition only the run time decides, of a name another method answers
# An initialize under a run-time condition in a Class.new block: when the
# branch does not run, C.new runs Object's initialize (CRuby: nil, then
# ArgumentError for C.new(1)); the constructor binds the initialize it
# calls by name, so the def is refused rather than standing as if it ran.
C = Class.new do
  def initialize(x) = (@x = x) if ENV["SPINEL_TEST_UNSET_VARIABLE"]
  def x = @x
end
p C.new.x
