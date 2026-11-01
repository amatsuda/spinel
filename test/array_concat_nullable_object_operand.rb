# An operand of concat held as an object that may be nil: nil has no to_ary
# to run, so the call raises CRuby's TypeError instead of calling the
# object's to_ary through a null pointer. An operand that is the object
# converts as usual.
class ConcatMaybeSource
  def to_ary = [2]
end
x = ARGV.empty? ? nil : ConcatMaybeSource.new
begin
  p [1].concat(x, [3])
rescue TypeError => e
  p e.message
end
y = ARGV.empty? ? ConcatMaybeSource.new : nil
p [1].concat(y, [3])
a = [0]
begin
  a.concat([5], x)
rescue TypeError => e
  p e.message
end
p a
